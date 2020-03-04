<?php

namespace App\Http\Controllers;

use Auth;
use Validator;
use Session;
use DB;
use App\Traits\HasPermission;
use Illuminate\Http\Request;

use \App\System;
use \App\Setting;
use App\Menu;
use App\MessageMaster;
use App\AppUserGroupMember;

class MessageController extends Controller
{
    use HasPermission;

	public function __construct(Request $request)
    {
        $this->page_title = $request->route()->getName();
        $description = \Request::route()->getAction();
        $this->page_desc = isset($description['desc']) ? $description['desc'] : $this->page_title;
    }

    public function all_messages(){
    	$data['page_title'] = $this->page_title;
		$data['module_name']= "Messages";
		$data['sub_module']= "All Messages";
		return view('message.all_messages',$data);
    }

    public function sentMessageManage(){
        $data['page_title'] = $this->page_title;
        $data['module_name']= "Messages";
        $data['sub_module']= "Sent Message";
        //action permissions
        $admin_user_id         = Auth::user()->id;
        $add_action_id         = 73;
        $add_permisiion        = $this->PermissionHasOrNot($admin_user_id,$add_action_id );
        $data['actions']['add_permisiion']= $add_permisiion;
        return view('message.sent_message_manage',$data);
    }

    //Message Entry And Update
    public function messageEntry(Request $request){
        $rule = [
            'admin_message' => 'Required',
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
                $is_active = ($request->is_active=="")?"0":"1";
                
                 $admin_id = Auth::user()->id;
                

                if ($request->message_edit_id == '') {

                    $message_id = MessageMaster::select('message_id')->orderBy('id','desc')->first();
                    
                    if ($message_id['message_id']=="") {
                        $message_id = 1;
                    }
                    else{
                        $message_id = $message_id['message_id']+1;
                    }

                    $app_user_group = $request->input('app_user_group');

                    if (isset($app_user_group)&& $app_user_group!="") {
                       
                        foreach ($app_user_group as $row) {
                            
                            $app_user_id = AppUserGroupMember::select('app_user_id')
                                            ->where('group_id',$row)
                                            ->distinct('app_user_id')
                                            ->get();
                                            
                            foreach ($app_user_id as $k) {
                                $app_user_id = $k['app_user_id'];
                                $column_value = [
                                    'admin_message'=>$request->admin_message,
                                    'admin_id'=>$admin_id,
                                    'app_user_id'=>$app_user_id,
                                    'message_id'=>$message_id,
                                    'status'=>$is_active,
                                ];
                                $response = MessageMaster::create($column_value);
                            }
                        }
                        
                        
                                            
                    }

                    else{
                        $column_value = [
                            'admin_message'=>$request->admin_message,
                            'admin_id'=>$admin_id,
                            'app_user_id'=>$request->app_user_id,
                            'message_id'=>$message_id,
                            'status'=>$is_active,
                       
                        ];
                        $response = MessageMaster::create($column_value);
                    }
                    

                }
                // else if($request->message_edit_id != ''){
                //     $data = User::find($request->id);
                //     $data->update($column_value);
                    
                // }
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


    //Message List
    public function messageList(){

        $admin_user_id      = Auth::user()->id;
        $edit_action_id     = 74;
        $delete_action_id   = 75;
        $edit_permisiion    = $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
        $delete_permisiion  = $this->PermissionHasOrNot($admin_user_id,$delete_action_id);

        $message_list = MessageMaster::Select('id', 'message_id', 'admin_id', 'admin_message', 'app_user_id', 'is_seen', 'status')
                        ->orderBy('id','desc')
                        ->get();
        $return_arr = array();
        foreach($message_list as $data){ 
            $data['is_seen']=($data->is_seen == 1)?"<button class='btn btn-xs btn-success' disabled>Seen</button>":"<button  class='btn btn-xs btn-danger' disabled>Not-seen</button>";       
            
            if ($data->status==0) {
                $data['status'] = "<button class='btn btn-xs btn-warning' disabled>In-active</button>";
            }
            else if($data->status==1){
                 $data['status'] = "<button class='btn btn-xs btn-success' disabled>Active</button>";
            }
            else if($data->status==2){
                 $data['status'] = "<button class='btn btn-xs btn-danger' disabled>Deleted</button>";
            }
            
            $data['actions']=" <button title='View' onclick='message_view(".$data->id.")' id='view_" . $data->id . "' class='btn btn-xs btn-primary' ><i class='clip-zoom-in'></i></button>";

            if($edit_permisiion>0){
                $data['actions'] .=" <button title='Edit' onclick='edit_message(".$data->id.")' id=edit_" . $data->id . "  class='btn btn-xs btn-green' ><i class='clip-pencil-3'></i></button>";
            }
            if ($delete_permisiion>0) {
                $data['actions'] .=" <button title='Delete' onclick='delete_message(".$data->id.")' id='delete_" . $data->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
            }
            $return_arr[] = $data;
        }
        return json_encode(array('data'=>$return_arr));
    }


    //Message view
    public function messageView($id){
        $data = MessageMaster::find($id);
        return json_encode($data);
    }


    //Message Delete
    public function messageDelete($id){
        MessageMaster::find($id)->delete();
        return json_encode(array(
            "deleteMessage"=>"Deleted Successful"
        ));
    }

    
    









}
