<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Validator;
use Session;
use DB;
use \App\System;
use App\AppUser;
use App\UserGroup;
use App\AppUserGroupMember;
use App\MessageMaster;
use App\MessageAttachment;
use Auth;
use App\Traits\HasPermission;

class AppUserController extends Controller
{
	use HasPermission;
	
	public function __construct(Request $request)
    {
        $this->page_title = $request->route()->getName();
        $description = \Request::route()->getAction();
        $this->page_desc = isset($description['desc']) ? $description['desc'] : $this->page_title;
    }

    public function index(){
    	$data['page_title'] = $this->page_title;
		$data['module_name']= "User";
		$data['sub_module']= "App Users";

		// action permissions
		$admin_user_id 	= Auth::user()->id;
		$add_action_id 	= 8;
		$add_permisiion = $this->PermissionHasOrNot($admin_user_id,$add_action_id );
		$data['actions']['add_permisiion']= $add_permisiion;

        return view('app_user.index', $data);
    }

    /*----- App User Entry And Update Start -----*/
    public function app_user_entry_update(Request $request){
    	$rule = [
            'app_user_name' => 'Required|max:50',
            'nid_no' => 'Required|max:20',
            'contact_no' => 'Required|max:20',
            'email' => 'Required|email',
            //'emp_image_upload' => 'mimes:jpeg,jpg,png,svg'
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
			$return['result'] = "0";
			$return['errors'] = $validation->errors();
			return json_encode($return);
        }
		else{
			//insert
			if ($request->app_user_edit_id == ''){
				#EmailCheck
	            $email_verification = AppUser::where('email',$request->email)->first();
	            if(isset($email_verification->id)){
					$return['result'] = "0";
					$return['errors'][] = $request->email." is already exists";
					return json_encode($return);
				}
			}
			//update
			else{
				 $email_verification = AppUser::where([['email',$request->email],['id', '!=', $request->app_user_edit_id]])->first();
           		if(isset($email_verification->id)){
					$return['result'] = "0";
					$return['errors'][] = $request->email." is already exists";
					return json_encode($return);
				}
			}		
			
			try{
				DB::beginTransaction();
				$password = ($request->password =="")?md5('1234'):md5($request->password);
				$is_active = ($request->is_active=="")?"0":$request->is_active;
				# Image
				$app_user_image = $request->file('app_user_image_upload');
				if (isset($app_user_image)) {
					
					$image_name = time();
					$ext = $app_user_image->getClientOriginalExtension();
					$image_full_name = $image_name.'.'.$ext;
					$upload_path = 'assets/images/user/app_user/';
					
					$success=$app_user_image->move($upload_path,$image_full_name);

					$column_value = [
					'name'=>$request->app_user_name,
					'nid_no'=>$request->nid_no,
					'contact_no'=>$request->contact_no,
					'email'=>$request->email,
					'address'=>$request->address,
					'password'=>$password,
					'status'=>$is_active,
					'remarks'=>$request->remarks,
					'user_profile_image'=>$image_full_name
				];
			}
			else{
				$column_value = [
					'name'=>$request->app_user_name,
					'nid_no'=>$request->nid_no,
					'contact_no'=>$request->contact_no,
					'email'=>$request->email,
					'address'=>$request->address,
					'password'=>$password,
					'status'=>$is_active,
					'remarks'=>$request->remarks
				];
			}

				
				#Entry
				if ($request->app_user_edit_id == '') {
					$response = AppUser::create($column_value);
					$app_user_id = $response->id;
					$group = $request->input('group');
					
					$app_user_group = UserGroup::select('id')->where('type',2)->get();
					foreach ($app_user_group as $app_user_group ) {
						$data_for_group_entry = new AppUserGroupMember();
						$data_for_group_entry->group_id=$app_user_group['id'];
						$data_for_group_entry->app_user_id=$app_user_id;
						$data_for_group_entry->status=0;
						$data_for_group_entry->save();
					}
					if ($group != "") {
						foreach ($group as $group ) {
							$a=	DB::table('app_user_group_members')->where('app_user_id',$app_user_id)->where('group_id',$group)->update(['status'=>1]);
						}
					}
					
				}
				#Update
				else if($request->app_user_edit_id != ''){
					$data = AppUser::find($request->app_user_edit_id);
					$data->update($column_value);
					$group = $request->input('group');
					//first don't permission then permission
					$do_not_permit = DB::table('app_user_group_members')
									->where('app_user_id',$request->app_user_edit_id)
									->update(['status'=>'0']);

					if ($group!="") {
						foreach ($group as $group ) {
							if (isset($group)) {
								$status = '1';
								$is_available_group = AppUserGroupMember::Select('group_id')
													->where('group_id',$group)
													->first();
													 
								if ($is_available_group['group_id']==$group) {
								 	$group_member_details = DB::table('app_user_group_members')
													->where('app_user_id',$request->app_user_edit_id)
													->where('group_id',$group)
													->update(['status'=>$status]);
								 }
								 else{
								 	$data_for_group_entry = new AppUserGroupMember();
									$data_for_group_entry->group_id=$group;
									$data_for_group_entry->app_user_id=$request->app_user_edit_id;
									$data_for_group_entry->status=$status;
									$data_for_group_entry->save();
								 } 
								
							}
						}
					}
					
				}
				DB::commit();
				$return['result'] = "1";
				return json_encode($return);
			}
			catch (\Exception $e){
				DB::rollback();
				$return['result'] = "0";
				$return['errors'][] ="Faild to save";
				return json_encode($return);
			}
		}
    }
    /*----- App User Entry And Update End -----*/


    /*----- App User List Start -----*/
    public function app_user_list(){
    	$app_user_image_path = asset('assets/images/user/app_user');
    	$admin_user_id 		= Auth::user()->id;
		$edit_action_id 	= 9;
		$delete_action_id 	= 10;
		$edit_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
		$delete_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$delete_action_id);
    	$app_user_details = AppUser::Select('id',  'name',  'email', 'status')->orderBy('id', 'desc')->get();		
		$return_arr = array();
		foreach($app_user_details as $user){

			$groups =  DB::table('app_user_group_members as augm')
					->leftJoin('user_groups as ug', 'augm.group_id', '=', 'ug.id')
					->select(DB::raw('group_concat("", ug.group_name, "") AS group_name'))
					->where('augm.app_user_id', $user->id)
					->where('augm.status', 1)
					->get();
			$user['groups_name'] = $groups[0]->group_name;	
			

			if($user->status == 0){
				$user['status']="<button class='btn btn-xs btn-warning' disabled>In-active</button>";
			}		
			else if($user->status == 1){
				$user['status']="<button class='btn btn-xs btn-success' disabled>Active</button>";
			}
			else{
				$user['status']="<button class='btn btn-xs btn-danger' disabled>Deleted</button>";
			}
			$user['actions']="<button title='View' onclick='app_user_view(".$user->id.")' id='view_" . $user->id . "' class='btn btn-xs btn-primary admin-user-view' ><i class='clip-zoom-in'></i></button>";

			if($edit_permisiion>0){
				$user['actions'] .=" <button title='Edit' onclick='app_user_edit(".$user->id.")' id=edit_" . $user->id . "  class='btn btn-xs btn-green admin-user-edit' ><i class='clip-pencil-3'></i></button>";
			}
			if ( $delete_permisiion>0 ) {
				$user['actions'] .=" <button title='Delete' onclick='delete_app_user(".$user->id.")' id='delete_" . $user->id . "' class='btn btn-xs btn-danger admin-user-delete' ><i class='clip-remove'></i></button>";
			}

			$return_arr[] = $user;
		}
		return json_encode(array('data'=>$return_arr));
    }
    /*----- App User List End -----*/


    /*----- App User Delete Start -----*/
    public function app_user_delete($id){
    	AppUser::find($id)->update(['status'=>2]);
		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
    }
    /*----- App User Delete End -----*/



    /*----- App User Edit Start -----*/
    public function app_user_edit($id){
    	$data = AppUser::find($id);

    	$user_group_member_details = DB::table('user_groups as ug')
									->leftJoin('app_user_group_members as ugm','ug.id','=','ugm.group_id')
									->where('ug.type','2')
									->where('ugm.app_user_id',$id)
									->select('ug.id as id','ug.group_name as group_name','ugm.app_user_id as app_user_id','ugm.status as status')
									->get();

		return json_encode(array(
			'app_user'=>$data,
			'user_group_member_details'=>$user_group_member_details
		));
    }
    /*----- App User Edit End -----*/


    /*----- App User View Start -----*/
    public function app_user_view($id){
    	$data = AppUser::find($id);
    	$groups =  DB::table('app_user_group_members as augm')
					->leftJoin('user_groups as ug', 'augm.group_id', '=', 'ug.id')
					->select(DB::raw('group_concat("", ug.group_name, "") AS group_name'))
					->where('augm.app_user_id', $id)
					->where('augm.status', 1)
					->get();

		return json_encode(array(
			'data'=>$data,
			'groups'=>$groups,
		));
    }
    /*----- App User View End -----*/


    /*----- App User Group Start -----*/
    public function app_user_management(){
    	$data['page_title'] = $this->page_title;
		$data['module_name']= "Settings";
		$data['sub_module']= "App User Groups";

		// action permissions
		$admin_user_id 	= Auth::user()->id;
		$add_action_id 	= 45;
		$add_permisiion = $this->PermissionHasOrNot($admin_user_id,$add_action_id );
		$data['actions']['add_permisiion']= $add_permisiion;

        return view('app_user.app_user_groups', $data);
    }
    public function load_app_user_groups(){

    	$admin_user_id 		= Auth::user()->id;
		$edit_action_id 	= 46;
		$delete_action_id 	= 47;
		$edit_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
		$delete_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$delete_action_id);

    	$app_user_group_list = UserGroup::Select('id', 'group_name', 'type','status')->where('type','2')->get();

		$return_arr = array();
		foreach($app_user_group_list as $app_user_group_list){
			$app_user_group_list['type']=($app_user_group_list->type == 1)?"Admin User":"App User";
			$app_user_group_list['status']=($app_user_group_list->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-danger' disabled>In-active</button>";
			$app_user_group_list['actions'] = "";

			if($edit_permisiion>0){
				$app_user_group_list['actions'] .="<button title='Edit' onclick='admin_group_edit(".$app_user_group_list->id.")' id=edit_" . $app_user_group_list->id . "  class='btn btn-xs btn-green' ><i class='clip-pencil-3'></i></button>";
			}
			if ($delete_permisiion>0) {
				$app_user_group_list['actions'] .=" <button title='Delete' onclick='admin_group_delete(".$app_user_group_list->id.")' id='delete_" . $app_user_group_list->id . "' class='btn btn-xs btn-danger'><i class='clip-remove'></i></button>";
			}
			
			$return_arr[] = $app_user_group_list;
		}
		return json_encode(array('data'=>$return_arr));
    }
    /*----- App User Group End -----*/



    /*----- Get App User Group List Start -----*/
    public function app_user_group_list_for_entry(){
    	$user_groups = UserGroup::Select('id','group_name')
			->where('status','1')
			->where('type','2')
			->get();
		return json_encode(array('data'=>$user_groups));
    }
    /*----- Get App User Group List End -----*/






    ############ Frontend App user message ##########
    public function appUserMessage($id){
    	$data = AppUser::where('id',$id)->get();
    	//return $data;

    	return view('frontend.message.app_user_message',compact('data'));
    }

    public function appUserMessageSave(Request $r){
    	$app_user_id = $r->app_user_id;
    	$app_user_message = $r->app_user_message;
    	$attachment = $r->file('app_user_attachment');

    	if($r->hasFile('app_user_attachment')){
			$app_user_msg_save = new MessageMaster();
			$app_user_msg_save->app_user_message = $app_user_message;
			$app_user_msg_save->app_user_id = $app_user_id;
			$app_user_msg_save->is_attachment_app_user = 1;
			$app_user_msg_save->save();
			$mm_id = $app_user_msg_save->id;
			
            foreach ($attachment as $attachment) {
                $attachment_name = rand().time().$attachment->getClientOriginalName();
                $ext = strtoupper($attachment->getClientOriginalExtension());
               
                if ($ext=="JPG" || $ext=="JPEG" || $ext=="PNG" || $ext=="GIF" || $ext=="WEBP" || $ext=="TIFF" || $ext=="PSD" || $ext=="RAW" || $ext=="INDD" || $ext=="SVG") {
                    $attachment_type = 1;
                }
                else if ($ext=="MP4" || $ext=="3GP") {
                    $attachment_type = 2;
                }
                else if ($ext=="MP3") {
                    $attachment_type = 3;
                }
                else{
                    $attachment_type = 4;
                }
                //$attachment_full_name = $attachment_name.'.'.$ext;
                $upload_path = 'assets/images/message/';
                    
                $success=$attachment->move($upload_path,$attachment_name);
                ##Save image to the message attachment table
                $msg_attachment = new MessageAttachment();
                $msg_attachment->message_master_id = $mm_id;
                $msg_attachment->app_user_attachment = $attachment_name;
                $msg_attachment->attachment_type = $attachment_type;
                $msg_attachment->save();
            }
         }

    	else{
    		$app_user_msg_save = new MessageMaster();
	    	$app_user_msg_save->app_user_id = $app_user_id;
	    	$app_user_msg_save->app_user_message = $app_user_message;
	    	$app_user_msg_save->save();
    	}
    	return redirect()->back();

    }

    ##App user report here

    public function appUserReport(){
    	$data['page_title'] = $this->page_title;
		$data['module_name']= "Reports";
		$data['sub_module']= "App User";

        return view('reports.app_user', $data);
    }

    public function appUserNameAutoComplete(){
		$name = $_REQUEST['term'];
		
		$data = AppUser::select('id', 'name', 'email', 'contact_no')
				->where('name','like','%'.$name.'%')
				->orwhere('email','like','%'.$name.'%')
				->orwhere('contact_no','like','%'.$name.'%')
				->get();
		$data_count = $data->count();

		 if($data_count>0){
            foreach ($data as $row) {
                $json[] = array('id' => $row["id"],'label' => $row["name"]." (".$row["email"].", ".$row["contact_no"].")" );
            }
        } 
        else {
            $json[] = array('id' => "0",'label' => "Not Found !!!");
        }
		return json_encode($json);
	}

	public function getAppUserReport($id){
		$app_user_report = AppUser::where('id', $id)->get();

		$group_name = DB::table('app_user_group_members as augm')
					->leftJoin('user_groups as ug', 'augm.group_id', '=', 'ug.id')
					->select(DB::raw('group_concat("", ug.group_name, "") AS group_name'))
					->where('augm.app_user_id', $id)
					->get();
		return json_encode(array(
			'app_user_report'=>$app_user_report,
			'group_name'=>$group_name,
		));
	}


   













    
}
