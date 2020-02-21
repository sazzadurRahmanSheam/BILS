<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Notice;
use App\UserGroup;
use App\AppUser;
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
            'expire_date' => 'Required',
            'notice_date' => 'Required',
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
			
			$data['actions']=" <button onclick='notice_view(".$data->id.")' id='view_" . $data->id . "' class='btn btn-xs btn-primary admin-user-view' ><i class='clip-zoom-in'></i></button>";

			if($edit_permisiion>0){
				$data['actions'] .=" <button onclick='edit_notice(".$data->id.")' id=edit_" . $data->id . "  class='btn btn-xs btn-green admin-user-edit' ><i class='clip-pencil-3'></i></button>";
			}
			if ($delete_permisiion>0) {
				$data['actions'] .=" <button onclick='delete_notice(".$data->id.")' id='delete_" . $data->id . "' class='btn btn-xs btn-danger admin-user-delete' ><i class='clip-remove'></i></button>";
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
		$data = AppUser::select('id', 'name')
				->
				;
		return json_encode($json);
	}




}
