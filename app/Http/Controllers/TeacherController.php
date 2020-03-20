<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Validator;
use Session;
use DB;
use \App\System;
use \App\User;
use App\UserGroup;
use App\Menu;
use Auth;
use App\Traits\HasPermission;
use App\CourseMaster;
use App\CourseCategory;
use App\AppUser;
use App\CoursePerticipant;
use App\Notification;
use App\Teacher;
use App\UserGroupMember;

class TeacherController extends Controller
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
		$data['module_name']= "Courses";
        $data['sub_module']= "Manage Teacher";
        // action permissions
        $admin_user_id  = Auth::user()->id;
        $add_action_id  = 89;
        $add_permisiion = $this->PermissionHasOrNot($admin_user_id,$add_action_id );
        $data['actions']['add_permisiion']= $add_permisiion;
        return view('teacher.teacher', $data);
    }

    ##Teache Entry
    public function teacherEntryUpdate(Request $request){
		$rule = [
            'name' => 'Required|max:100',
            'contact_no' => 'Required|max:20',
            'nid' => 'Required|max:20',
            'email' => 'Required|email|max:100',
            
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
			$return['result'] = "0";
			$return['errors'] = $validation->errors();
			return json_encode($return);
        }
		else{
			//insert
			if ($request->teacher_edit_id == ''){
				#EmailCheck
	            $email_verification = Teacher::where('email',$request->email)->first();
	            if(isset($email_verification->id)){
					$return['result'] = "0";
					$return['errors'][] = $request->email." is already exists";
					return json_encode($return);
				}
			}
			#update
			else{
				 $email_verification = Teacher::where([['email',$request->email],['id', '!=', $request->teacher_edit_id]])->first();
				
           		if(isset($email_verification->id)){
					$return['result'] = "0";
					$return['errors'][] = $request->email." is already exists";
					return json_encode($return);
				}
			}

			try{
				DB::beginTransaction();
				$is_active = ($request->is_active=="")?"0":"1";

				$password = md5('1234');
				$column_value = [
					'name'=>$request->name,
					'nid'=>$request->nid,
					'contact_no'=>$request->contact_no,
					'email'=>$request->email,
					'address'=>$request->address,
					'status'=>$is_active,
				];

				if ($request->teacher_edit_id == '') {
					$response = Teacher::create($column_value);
					if($request->teacher_id == ''){

						$email_verification_admin = User::where('email',$request->email)->first();
			            if(isset($email_verification_admin->id)){
							$return['result'] = "0";
							$return['errors'][] = $request->email." is already exists";
							return json_encode($return);
						}
						
							$column_value1 = [
								'name'=>$request->name,
								'nid_no'=>$request->nid,
								'contact_no'=>$request->contact_no,
								'email'=>$request->email,
								'address'=>$request->address,
								'password'=>$password,
								'status'=>$is_active,
								'user_type'=>3,
							];
							$response = User::create($column_value1);
							
							$t_id = $response->id;
							$group_id=37;
							$status = 1;
							
							$data_for_group_entry = new UserGroupMember();
							$data_for_group_entry->group_id=$group_id;
							$data_for_group_entry->emp_id=$t_id;
							$data_for_group_entry->status=$status;
							$data_for_group_entry->save();

							$get_group_id = UserGroup::select('id')->where('type',1)->where('id','!=',$group_id)->get();
							foreach ($get_group_id as $get_group_id ){
								$group_entry = new UserGroupMember();
								$group_entry->group_id=$get_group_id['id'];
								$group_entry->emp_id=$t_id;
								$group_entry->status=0;
								$group_entry->save();
						}
						
					}

				}
				else if($request->teacher_edit_id != ''){
					$data = Teacher::find($request->teacher_edit_id);
					$data->update($column_value);
					
					$admin_user_update = User::find($request->admin_id);
					$column_value2 = [
						'name'=>$request->name,
						'nid_no'=>$request->nid,
						'contact_no'=>$request->contact_no,
						'email'=>$request->email,
						'address'=>$request->address,
						'status'=>$is_active,
					];
					$admin_user_update->update($column_value2);

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




    public function adminUserNameAutoComplete(){
		$name = $_REQUEST['term'];
		
		$data = User::select('id', 'name', 'nid_no', 'contact_no', 'email', 'address')
				->where('name','like','%'.$name.'%')
				->get();
		$data_count = $data->count();

		 if($data_count>0){
            foreach ($data as $row) {
                $json[] = array('id' => $row["id"],'label' => $row["name"], 'email' => $row["email"], 'nid_no' => $row["nid_no"], 'contact_no' => $row["contact_no"], 'address' => $row["address"] );
            }
        } 
        else {
            $json[] = array('id' => "0",'label' => "Not Found !!!");
        }
		return json_encode($json);
	}

	//Teacher List
	public function teacherList(){
		$admin_user_id 		= Auth::user()->id;
		$edit_action_id 	= 90;
		$delete_action_id 	= 91;
		$edit_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
		$delete_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$delete_action_id);

		$teacher_list = Teacher::Select('id', 'name', 'email', 'contact_no', 'status')->get();
		$return_arr = array();
		foreach($teacher_list as $row){
			$row['actions']="<button title='View' onclick='teacher_view(".$row->id.")' id=view_" . $row->id . "  class='btn btn-xs btn-info ' ><i class='clip-zoom-in'></i></button>";

			if($edit_permisiion>0 ){//&& $row->status != 2
				$row['actions'] .=" <button title='Edit' onclick='teacher_edit(".$row->id.")' id=edit_" . $row->id . "  class='btn btn-xs btn-green module-edit' ><i class='clip-pencil-3'></i></button>";
			}
			if ($delete_permisiion>0 && $row->status != 2) {
				$row['actions'] .=" <button title='Delete' onclick='teacher_delete(".$row->id.")' id='delete_" . $row->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
			}
			if($row->status == 0){
				$row['status'] = "<button class='btn btn-xs btn-warning' disabled>In-active</button>";
			}
			else if($row->status == 1){
				$row['status']="<button class='btn btn-xs btn-success' disabled>Active</button>";
			}
			if($row->status == 2){
				$row['status']="<button class='btn btn-xs btn-danger' disabled>Deleted</button>";
			}

			$return_arr[] = $row;
		}
		return json_encode(array('data'=>$return_arr));

	}

	public function teacherEdit($id){
		$data = Teacher::find($id);
		$admin_id = User::select('id')->where('email', $data['email'])->first();

		return json_encode(array(
			"data"=>$data,
			"admin_id"=>$admin_id
		));
	}

	public function teacherDelete($id){
		$data = Teacher::find($id)->update(['status'=>2]);
		return json_encode(array(
			"deleteMessage"=>"Teacher Deleted Successful"
		));
	}

	//Teacher View
	public function teacherView($id){
		$data = Teacher::find($id);
		return json_encode($data);
	}





}
