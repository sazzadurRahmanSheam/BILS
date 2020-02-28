<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Notice;
use App\Notification;
use App\UserGroup;
use App\AppUser;
use App\AppUserGroupMember;

use Auth;
use Validator;
use Session;
use DB;
use App\Traits\HasPermission;

class NoticeController extends Controller
{
	use HasPermission;
	
    public function __construct(Request $request)
    {
        $this->page_title = $request->route()->getName();
        $description = \Request::route()->getAction();
        $this->page_desc = isset($description['desc']) ? $description['desc'] : $this->page_title;
    }
	
    public function noticeManagement(){
    	$data['page_title'] = $this->page_title;
		$data['module_name']= "Notice";
		$data['sub_module']= "";	
		//action permissions
		$admin_user_id 		   = Auth::user()->id;
		$add_action_id 	   	   = 65;
		$add_permisiion 	   = $this->PermissionHasOrNot($admin_user_id,$add_action_id );
		$data['actions']['add_permisiion']= $add_permisiion;	

        return view('notice.notice_management', $data);
    }

    public function load_app_user_groups(){
    	$app_user_group = UserGroup::where('type','2')->get();
    	return json_encode($app_user_group);
    }

    //Notice Entry And Update
    public function noticeEntry(Request $request){ 
		$rule = [
            'title' => 'Required|max:200',
            'details' => 'Required',
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
			$return['result'] = "0";
			$return['errors'] = $validation->errors();
			return json_encode($return);
        }
		else{
			/*----- For notification -----*/
			$app_user_group = $request->input('app_user_group');
			$app_user_name = $request->app_user_name;
			$app_user_id = $request->app_user_id;
			$from_id = Auth::user()->id;
			$from_user_type = 'Admin';
			$to_user_type = 'App User';
			$notification_title = $request->title;
			$message = $request->details;
			/*----- For notification -----*/
			
			
				
			try{
				DB::beginTransaction();
				$status = ($request->is_active =="")?'0':'1';

				if ($request->notice_edit_id == '') {
					$created_by = Auth::user()->name;
					$column_value = [
						'title'=>$request->title,
						'details'=>$request->details,
						'status'=>$status,	
						'notice_date'=>$request->notice_date,	
						'expire_date'=>$request->expire_date,	
						'created_by'=>$created_by,	
					];
					$response = Notice::create($column_value);

					## Insert Into Notification For Single App User
					if (isset($app_user_id)&&isset($app_user_name)&&$app_user_id!=""&&$app_user_name!="") {
						
						$to_id = $app_user_id;
						
						
						$column_value = [
							'from_id'=>$from_id,
							'from_user_type'=>$from_user_type,
							'to_id'=>$to_id,	
							'to_user_type'=>$to_user_type,	
							'notification_title'=>$notification_title,	
							'message'=>$message,	
						];
						$response = Notification::create($column_value);
					}
					if (isset($app_user_group)&& $app_user_group!="") {
						foreach ($app_user_group as $row) {
							$to_user_id = AppUserGroupMember::distinct()
											->select('app_user_id')
											->where('group_id',$row)
											->groupBy('app_user_id')
											->get();

							foreach ($to_user_id as $k) {
								
								$to_id = $k['app_user_id'];
								$column_value = [
									'from_id'=>$from_id,
									'from_user_type'=>$from_user_type,
									'to_id'=>$to_id,	
									'to_user_type'=>$to_user_type,	
									'notification_title'=>$notification_title,	
									'message'=>$message,	
								];
								$response = Notification::create($column_value);
							}
						}
					}


				}
				else{
					$updated_by = Auth::user()->name;
					$column_value = [
						'title'=>$request->title,
						'details'=>$request->details,
						'status'=>$status,
						'notice_date'=>$request->notice_date,
						'expire_date'=>$request->expire_date,
						'updated_by'=>$updated_by,
					];

					$data = Notice::find($request->notice_edit_id);
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

	//Notice List
	public function noticeList(){

		$admin_user_id 		= Auth::user()->id;
		$edit_action_id 	= 66;
		$delete_action_id 	= 67;
		$edit_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
		$delete_permisiion 	= $this->PermissionHasOrNot($admin_user_id,$delete_action_id);

		$notice_list = Notice::Select('id', 'title', 'details', 'status')
						->orderBy('id','desc')
						->get();
		$return_arr = array();
		foreach($notice_list as $data){		
			$data['status']=($data->status == 1)?"<button class='btn btn-xs btn-success' disabled>Active</button>":"<button class='btn btn-xs btn-danger' disabled>In-active</button>";
			
			$data['actions']=" <button title='View' onclick='notice_view(".$data->id.")' id='view_" . $data->id . "' class='btn btn-xs btn-primary admin-user-view' ><i class='clip-zoom-in'></i></button>";

			if($edit_permisiion>0){
				$data['actions'] .=" <button title='Edit' onclick='edit_notice(".$data->id.")' id=edit_" . $data->id . "  class='btn btn-xs btn-green admin-user-edit' ><i class='clip-pencil-3'></i></button>";
			}
			if ($delete_permisiion>0) {
				$data['actions'] .=" <button title='Delete' onclick='delete_notice(".$data->id.")' id='delete_" . $data->id . "' class='btn btn-xs btn-danger admin-user-delete' ><i class='clip-remove'></i></button>";
			}
			$return_arr[] = $data;
		}
		return json_encode(array('data'=>$return_arr));
	}

	//Notice view
	public function noticeView($id){
    	$data = Notice::find($id);
		return json_encode($data);
    }

    //Notice Delete
    public function noticeDelete($id){
		Notice::find($id)->delete();
		return json_encode(array(
			"deleteMessage"=>"Deleted Successful"
		));
	}

	//Notice edit data
	public function noticeEdit($id){
		$data = Notice::find($id);
		return json_encode($data);
	}

	public function appUserNameAutoComplete(){
		$name = $_REQUEST['term'];
		
		$data = AppUser::select('id', 'name')
				->where('name','like','%'.$name.'%')
				->get();
		$data_count = $data->count();

		 if($data_count>0){
            foreach ($data as $row) {
                $json[] = array('id' => $row["id"],'label' => $row["name"]);
            }
        } 
        else {
            $json[] = array('id' => "0",'label' => "Not Found !!!");
        }
		return json_encode($json);
	}




}
