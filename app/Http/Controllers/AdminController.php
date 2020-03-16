<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use Validator;
use Session;
use DB;
use \App\System;
use \App\User;
use App\UserGroup;
use App\UserGroupMember;
use App\Menu;
use App\UserGroupPermission;
use App\WebAction;
use App\Traits\HasPermission;

class AdminController extends Controller
{
	use HasPermission;

    public function __construct(Request $request)
    {
        $this->page_title = $request->route()->getName();
        $description = \Request::route()->getAction();
        $this->page_desc = isset($description['desc']) ? $description['desc'] : $this->page_title;
    }

	public function index()
    {
        $data['page_title'] = $this->page_title;
		$data['module_name']= "";
		$data['sub_module']= "";
        return view('admin.dashbord', $data);
    }

	public function adminUserManagement(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "User";
		$data['sub_module']= "Admin Users";
		// action permissions
		$admin_user_id 		   = Auth::user()->id;
		$add_action_id 	   	   = 2;
		$add_permisiion 	   = $this->PermissionHasOrNot($admin_user_id,$add_action_id );
		$data['actions']['add_permisiion']= $add_permisiion;

        return view('admin.index', $data);
	}

	public function ajaxAdminList(){

		$admin_user_id 		= Auth::user()->id;
		$edit_action_id 	= 4;
		$delete_action_id 	= 6;
		$edit_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
		$delete_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$delete_action_id);

		//$public_path = public_path();
		$a = asset('assets/images/user/admin');
		$adminUser = User::Select('user_profile_image', 'id',  'name',  'email', 'status')->where('user_type','1')
			->orderBy('created_at','desc')
			->get();
		$return_arr = array();
		foreach($adminUser as $user){
			$user['user_profile_image'] = '<img height="70" max-width="100" src="'.$a.'/'.$user->user_profile_image.'" alt="image" />';
			
			if($user->status == 0){$user['status']="<button class='btn btn-xs btn-warning' disabled>In-active</button>";}
			else if($user->status == 1){$user['status']="<button class='btn btn-xs btn-success' disabled>Active</button>";}
			else{$user['status']="<button class='btn btn-xs btn-danger' disabled>Deleted</button>";}

			$user['actions']=" <button onclick='admin_user_view(".$user->id.")' id='view_" . $user->id . "' class='btn btn-xs btn-primary admin-user-view' ><i class='clip-zoom-in'></i></button>";

			if($edit_permisiion>0){
				$user['actions'] .=" <button onclick='admin_user_edit(".$user->id.")' id=edit_" . $user->id . "  class='btn btn-xs btn-green admin-user-edit' ><i class='clip-pencil-3'></i></button>";
			}
			if ($delete_permisiion > 0) {
				
					$user['actions'] .=" <button onclick='delete_admin_user(".$user->id.")' id='delete_" . $user->id . "' class='btn btn-xs btn-danger admin-user-delete' ><i class='clip-remove'></i></button>";
				
			}
			$return_arr[] = $user;
		}
		return json_encode(array('data'=>$return_arr));
	}

	## Admin User Entry And Update
	public function ajaxAdminEntry(Request $request){
		$rule = [
            'emp_name' => 'Required|max:220',
            'nid_no' => 'Required|max:20',
            'contact_no' => 'Required|max:13',
            'email' => 'Required|email',
            'emp_image_upload' => 'mimes:jpeg,jpg,png,svg'
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
			$return['result'] = "0";
			$return['errors'] = $validation->errors();
			return json_encode($return);
        }
		else{
			#Insert
			if ($request->id == ''){
				#EmailCheck
	            $email_verification = User::where('email',$request->email)->first();
	            if(isset($email_verification->id)){
					$return['result'] = "0";
					$return['errors'][] = $request->email." is already exists";
					return json_encode($return);
				}
			}
			#update
			else{
				#EmailCheck
				 $email_verification = User::where([['email',$request->email],['id', '!=', $request->id]])->first();
           		if(isset($email_verification->id)){
					$return['result'] = "0";
					$return['errors'][] = $request->email." is already exists";
					return json_encode($return);
				}
			}

			try{
				DB::beginTransaction();
				$is_active = ($request->is_active=="")?"0":"1";
				$password = ($request->password =="")?md5('1234'):md5($request->password);
				# Image
				$admin_image = $request->file('user_profile_image');
				if (isset($admin_image)) {
					
					$image_name = time();
					$ext = $admin_image->getClientOriginalExtension();
					$image_full_name = $image_name.'.'.$ext;
					$upload_path = 'assets/images/user/admin/';
					
					$success=$admin_image->move($upload_path,$image_full_name);

					$column_value = [
						'name'=>$request->emp_name,
						'nid_no'=>$request->nid_no,
						'contact_no'=>$request->contact_no,
						'email'=>$request->email,
						'address'=>$request->address,
						'password'=>$password,
						'status'=>$is_active,
						'remarks'=>$request->remarks,
						'user_profile_image'=>$image_full_name,
					];
				}
				else{
					$column_value = [
						'name'=>$request->emp_name,
						'nid_no'=>$request->nid_no,
						'contact_no'=>$request->contact_no,
						'email'=>$request->email,
						'address'=>$request->address,
						'password'=>$password,
						'status'=>$is_active,
						'remarks'=>$request->remarks,
					];
				}

				if ($request->id == '') {
					$response = User::create($column_value);
					$emp_id = $response->id;
					$group = $request->input('group');
					$status = 1;
					if ($group!="") {
						foreach ($group as $group ) {
							$data_for_group_entry = new UserGroupMember();
							$data_for_group_entry->group_id=$group;
							$data_for_group_entry->emp_id=$emp_id;
							$data_for_group_entry->status=$status;
							$data_for_group_entry->save();
						}
					}

				}
				else if($request->id != ''){
					$data = User::find($request->id);
					$old_image = $data->user_profile_image;
					if (isset($admin_image)&&$old_image!="") {
						$delete_img = $upload_path.$old_image;
						unlink($delete_img);
					}
					$data->update($column_value);
					

					$group = $request->input('group');

					## First don't permission then permission
					$do_not_permit = DB::table('user_group_members')
									->where('emp_id',$request->id)
									->update(['status'=>'0']);
					## Set Admin Use Group Member
					if ($group!="") {
						foreach ($group as $group ) {
							if (isset($group)) {
								$status = '1';
								$group_member_details = DB::table('user_group_members')
														->where('emp_id',$request->id)
														->where('group_id',$group)
														->update(['status'=>$status]);
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
				$return['errors'][] ="Failed to save";
				return json_encode($return);
			}
		}
	}


	//Admin user delete
	public function adminDestroy($id){
		User::where('id',$id)->update(['status'=>2]);

		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
	}

	//Admin User View
	public function adminUserView($id){
		$data = User::find($id);
		return json_encode($data);
	}


	/*-----Admin User Data for edit and get group-----*/
	public function adminUserEdit($id){
		$emp_id = $id;
		$data = User::find($emp_id);

		$user_group_member_details = DB::table('User_groups as ug')
									->leftJoin('User_group_members as ugm','ug.id','=','ugm.group_id')
									->where('ug.type','1')
									->where('ugm.emp_id',$emp_id)
									->select('ug.id as id','ug.group_name as group_name','ugm.emp_id as emp_id','ugm.status as status')
									->get();
		return json_encode(array(
			"data"=>$data,
			"user_group_member_details"=>$user_group_member_details
		));
	}


	//Admin User Groups
	public function admin_user_groups(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Settings";
		$data['sub_module']= "Admin User Groups";
		// action permissions
        $admin_user_id  = Auth::user()->id;
        $add_action_id  = 40;
        $add_permisiion = $this->PermissionHasOrNot($admin_user_id,$add_action_id );
        $data['actions']['add_permisiion']= $add_permisiion;

        return view('admin.admin_groups', $data);
	}
	/*Entry Admin User Group And App User Group*/
	public function admin_groups_entry_or_update(Request $request){

		$rule = [
            'group_name' => 'Required|max:50',
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
			$return['result'] = "0";
			$return['errors'] = $validation->errors();
			return json_encode($return);
        }
		else{
			try{
				DB::beginTransaction();
				$status = ($request->is_active =="")?'0':'1';

				$column_value = [
					'group_name'=>$request->group_name,
					'type'=>$request->type,
					'status'=>$status,
				];

				if ($request->edit_id == '') {
					
					$response = UserGroup::create($column_value);
					## Get group id
					$group_id = $response->id;
					
					## Get All User
					$admin_emp_id = User::Select('id')->orderBy('id')->get();
					
					## Assign Admin user Group for all Admin user with status 0
					foreach($admin_emp_id as $admin_emp_id){
						$admin_user_group_member = new UserGroupMember();
						$admin_user_group_member->emp_id = $admin_emp_id['id'];
						$admin_user_group_member->group_id = $group_id;
						$admin_user_group_member->status = '0';
						$admin_user_group_member->save();
						//echo $admin_emp_id;
					}

					## Get Action id
					$action_id = WebAction::Select('id')->get();
					##Save permission
					foreach ($action_id as $action_id) {
						$user_group_permissions = new UserGroupPermission();
						$user_group_permissions->group_id=$group_id;
						$user_group_permissions->action_id=$action_id['id'];
						$user_group_permissions->status='0';
						$user_group_permissions->save();
					}
				}
				else{
					
					$data = UserGroup::find($request->edit_id);
					$data->update($column_value);
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


	//Admin Group show
	public function admin_groups_list(){

		$admin_user_id 		= Auth::user()->id;
		$edit_action_id 	= 42;
		$delete_action_id 	= 43;
		$give_permission_action_id = 41;
		$edit_permisiion  = $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
		$delete_permisiion = $this->PermissionHasOrNot($admin_user_id,$delete_action_id);
		$give_permission = $this->PermissionHasOrNot($admin_user_id,$give_permission_action_id);

		$admin_group_list = UserGroup::Select('id', 'group_name', 'type','status')->where('type','1')->get();
		$return_arr = array();
		foreach($admin_group_list as $admin_group_list){
			$admin_group_list['type']=($admin_group_list->type == 1)?"Admin User":"App User";
			$admin_group_list['status']=($admin_group_list->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-danger' disabled>In-active</button>";

			$admin_group_list['actions'] = "";
			if($give_permission>0){
				$admin_group_list['actions'] .="<button title='Permission' onclick='group_permission(".$admin_group_list->id.")' id=permission_" . $admin_group_list->id . "  class='btn btn-xs btn-warning' ><i class='clip-grid-3'></i></button>";
			}
			if($edit_permisiion>0){
				$admin_group_list['actions'] .=" <button title='Edit' onclick='admin_group_edit(".$admin_group_list->id.")' id=edit_" . $admin_group_list->id . "  class='btn btn-xs btn-green' ><i class='clip-pencil-3'></i></button>";
			}
			if ($delete_permisiion>0) {
				$admin_group_list['actions'] .=" <button title='Delete' onclick='admin_group_delete(".$admin_group_list->id.")' id='delete_" . $admin_group_list->id . "' class='btn btn-xs btn-danger'><i class='clip-remove'></i></button>";
			}

			$return_arr[] = $admin_group_list;
		}
		return json_encode(array('data'=>$return_arr));
	}

	//Admin Group Edit
	public function admin_group_edit($id){
		$data = UserGroup::Select('id','group_name','type','status')->where('id',$id)->first();
		return json_encode($data);
	}

	//admin group delete
	public function admin_group_delete($id){
		UserGroup::find($id)->delete();
		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
	}



	 public function load_user_groups(){
		$user_groups = UserGroup::Select('id','group_name')
			->where('status','1')
			->where('type','1')
			->get();
		return json_encode(array('data'=>$user_groups));
    }

    public function load_actions_for_group_permission($id){
    	$group_id = $id;
    	$permission_details = DB::table('user_group_permissions as up')
    							->leftJoin('web_actions as wa', 'up.action_id', '=', 'wa.id')
    							->leftJoin('menus as m','wa.module_id','=','m.id')
    							->where('up.group_id',$group_id)
    							->where('wa.status','1')
    							->select('up.*', 'wa.activity_name', 'm.module_name')
    							->get();
		return json_encode(array('data'=>$permission_details));
    }


    public function permission_action_entry_update(Request $request){
		$permission_action = $request->input('permission_action');
		$group_id = $request->group_id;

		try{
			DB::beginTransaction();

			$data_for_permission_action_update = DB::table('User_group_permissions')
															->where('group_id',$group_id)
															->update(['status'=>'0']);

			if($permission_action!=""){
				foreach ($permission_action as $permission_action ) {

					if (isset($permission_action)) {
						$status = '1';
						$data_for_permission_action_update = DB::table('User_group_permissions')
															->where('group_id',$group_id)
															->where('action_id',$permission_action)
															->update(['status'=>$status]);
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

