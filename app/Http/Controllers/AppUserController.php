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
					$status = 1;
					if ($group!="") {
						foreach ($group as $group ) {
							$data_for_group_entry = new AppUserGroupMember();
							$data_for_group_entry->group_id=$group;
							$data_for_group_entry->app_user_id=$app_user_id;
							$data_for_group_entry->status=$status;
							$data_for_group_entry->save();
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
    	$app_user_details = AppUser::Select('user_profile_image', 'id',  'name',  'email', 'status')->orderBy('id', 'desc')->get();		
		$return_arr = array();
		foreach($app_user_details as $user){	
			$user['app_user_profile_image'] = '<img height="70" max-width="100" src="'.$app_user_image_path.'/'.$user->user_profile_image.'" alt="image" />';

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
		return json_encode($data);
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


   













    
}
