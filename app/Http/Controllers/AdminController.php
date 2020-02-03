<?php

namespace App\Http\Controllers;
//later i will use use App\Traits\HasRoleAndPermission;
use Illuminate\Http\Request;
use Validator;
use Session;
use DB;
use \App\System;
use \App\User;

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
				}
				else if($request->id != ''){
					$data = User::find($request->id);
					$data->update($column_value);
					// echo $data;
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
}

