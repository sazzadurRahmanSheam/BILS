<?php

namespace App\Http\Controllers;
//later i will use use App\Traits\HasRoleAndPermission;
use Illuminate\Http\Request;
use Validator;
use Session;
use DB;
use \App\System;
use \App\User;
use App\User_group;
use App\User_group_member;
use App\Menu;
use App\User_group_permission;

class AdminController extends Controller
{
    public function __construct(Request $request)
    {
        $this->page_title = $request->route()->getName();
        $description = \Request::route()->getAction();
        $this->page_desc = isset($description['desc']) ? $description['desc'] : $this->page_title;
    }
	
	public function index()
    {
        $data['page_title'] = $this->page_title;
		$data['module_name']= "User";
        return view('admin.dashbord', $data);
    }
	
	public function adminUserManagement(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "User";
        return view('admin.index', $data);
	}
	
	public function ajaxAdminList(){
		$adminUser = User::Select('user_profile_image', 'id',  'name',  'email', 'status')->where('user_type','1')->orderBy('created_at','desc')->get();		
	//	dd($adminUser);
		$return_arr = array();
		foreach($adminUser as $user){			
			$user['status']=($user->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-success' disabled>In-active</button>";
			$user['actions']="<button onclick='admin_user_edit(".$user->id.")' id=edit_" . $user->id . "  class='btn btn-xs btn-green admin-user-edit' ><i class='clip-pencil-3'></i></button>"
							." <button onclick='admin_user_view(".$user->id.")' id='view_" . $user->id . "' class='btn btn-xs btn-primary admin-user-view' ><i class='clip-zoom-in'></i></button>"
							." <button onclick='delete_admin_user(".$user->id.")' id='delete_" . $user->id . "' class='btn btn-xs btn-danger admin-user-delete' ><i class='clip-remove'></i></button>";
			$return_arr[] = $user;
		}
		return json_encode(array('data'=>$return_arr));
       // return view('admin.manage', $data);
	}	
	
	// emp_name nid_no contact_no email address password is_active remarks emp_image_upload
	
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
			//insert
			if ($request->id == ''){
				#EmailCheck
            $email_verification = User::where('email',$request->email)->first();
            if(isset($email_verification->id)){
				$return['result'] = "0";
				$return['errors'][] = $request->email." is already exists";
				return json_encode($return);
			}
			}
			//update
			else{
				 $email_verification = User::where([['email',$request->email],['id', '!=', $request->id]])->first();
           		if(isset($email_verification->id)){
					$return['result'] = "0";
					$return['errors'][] = $request->email." is already exists";
					return json_encode($return);
				}
			}		
			
			try{
				DB::beginTransaction();
								$password = ($request->password =="")?md5('1234'):md5($request->password);
				$column_value = [
					'name'=>$request->emp_name,
					'nid_no'=>$request->nid_no,
					'contact_no'=>$request->contact_no,
					'email'=>$request->email,
					'address'=>$request->address,
					'password'=>$password,
					'status'=>$request->is_active,
					'remarks'=>$request->remarks
					//'user_profile_image'=>$image_name,	
				];
				
				if ($request->id == '') {
					$response = User::create($column_value);
					$emp_id = $response->id;
					$group = $request->input('group');
					$status = 1;
					if ($group!="") {
						foreach ($group as $group ) {
							$data_for_group_entry = new User_group_member();
							$data_for_group_entry->group_id=$group;
							$data_for_group_entry->emp_id=$emp_id;
							$data_for_group_entry->status=$status;
							$data_for_group_entry->save();
						}
					}

				}
				else if($request->id != ''){
					$data = User::find($request->id);
					$data->update($column_value);
					$group = $request->input('group');
					$status = 1;
					if ($group!="") {
						foreach ($group as $group ) {
							$data_for_group_entry = new User_group_member();
							$data_for_group_entry->group_id=$group;
							$data_for_group_entry->emp_id=$request->id;
							$data_for_group_entry->status=$status;
							$data_for_group_entry->save();
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


	//Admin user delete
	public function adminDestroy($id){
		User::find($id)->delete();
		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
	}

	//Admin User View
	public function adminUserView($id){
		$data = User::find($id);
		return json_encode($data);
	}


	public function adminUserEdit($id){
		$data = User::find($id);
		return json_encode($data);
	}


	//Admin User Groups
	public function admin_user_groups(){
		$data['page_title'] = $this->page_title;
		$data['module_name']= "Settings";
        return view('admin.admin_groups', $data);
	}

	public function admin_groups_entry_or_update(Request $request){ 

		$rule = [
            'group_name' => 'Required|max:50',
            'type' => 'Required',
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
					$response = User_group::create($column_value);
				}
				else{
					$data = User_group::find($request->edit_id);
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
		$admin_group_list = User_group::Select('id', 'group_name', 'type','status')->get();		
		$return_arr = array();
		foreach($admin_group_list as $admin_group_list){
			$admin_group_list['type']=($admin_group_list->type == 1)?"Admin User":"App User";
			$admin_group_list['status']=($admin_group_list->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-danger' disabled>In-active</button>";
			$admin_group_list['actions']="<button title='Permission' onclick='group_permission(".$admin_group_list->id.")' id=permission_" . $admin_group_list->id . "  class='btn btn-xs btn-warning' ><i class='clip-grid-3'></i></button>"
				." <button title='Edit' onclick='admin_group_edit(".$admin_group_list->id.")' id=edit_" . $admin_group_list->id . "  class='btn btn-xs btn-green' ><i class='clip-pencil-3'></i></button>"
				." <button title='Delete' onclick='admin_group_delete(".$admin_group_list->id.")' id='delete_" . $admin_group_list->id . "' class='btn btn-xs btn-danger'><i class='clip-remove'></i></button>";
			$return_arr[] = $admin_group_list;
		}
		return json_encode(array('data'=>$return_arr));
	}

	//Admin Group Edit
	public function admin_group_edit($id){
		$data = User_group::Select('id','group_name','type','status')->where('id',$id)->first();
		return json_encode($data);
	}

	//admin group delete
	public function admin_group_delete($id){
		User_group::find($id)->delete();
		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
	}



	 public function load_user_groups(){
		$user_groups = User_group::Select('id','group_name')
			->where('status','1')
			->get();
		echo json_encode(array('data'=>$user_groups));
    }

    public function load_actions_for_group_permission(){
    	$actions = Menu::Select('id','menu_title')
			->where('status','1')
			->where('parent_id','<>','0')
			->get();
		echo json_encode(array('data'=>$actions));
    }


    public function permission_action_entry_update(Request $request){
		$permission_action = $request->input('permission_action');
		$group_id = $request->group_id;
		$status = 1;
		try{
			DB::beginTransaction();
			if ($permission_action != "") {
				foreach ($permission_action as $permission_action ) {
					$data_for_permission_action_entry = new User_group_permission();
					$data_for_permission_action_entry->action_id=$permission_action;
					$data_for_permission_action_entry->group_id=$group_id;
					$data_for_permission_action_entry->status=$status;
					$data_for_permission_action_entry->save();
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

