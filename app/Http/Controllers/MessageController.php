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
use App\AppUser;
use App\MessageAttachment;

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


    ## Load app user for message
    public function loadAppUser(){
        
        //$app_user = AppUser::get();
        $app_user_info = DB::table('message_masters as mm')
                            ->leftJoin('app_users as apu', 'mm.app_user_id', '=', 'apu.id')
                            ->select('apu.name as name','apu.id as app_user_id')
                            ->distinct('mm.app_user_id')
                            //->orderBy('mm.message_date_time', 'desc')
                            ->orderBy('mm.id', 'desc')
                            ->get();
        // $message = DB::table('message_masters as mm')
        //                     ->leftJoin('app_users as apu', 'mm.app_user_id', '=', 'apu.id')
        //                     ->where('mm.app_user_id',5)
        //                     ->select('mm.id as id', 'mm.app_user_id as app_user_id', 'mm.app_user_message as app_user_message', 'mm.admin_id as admin_id', 'mm.admin_message as admin_message')
        //                     ->orderBy('mm.created_at')
        //                     ->get();
        

        return json_encode(array(
            "app_user_info"=>$app_user_info,
            // "message"=>$message,
        ));
    }


     ## Load app user message
    public function loadMessage(){
        $app_user_id_load_msg = $_POST['app_user_id_load_msg'];
        $number_of_msg = $_POST['msg_no'];
        $message = DB::table('message_masters as mm')
                            ->leftJoin('app_users as apu', 'mm.app_user_id', '=', 'apu.id')
                            ->leftJoin('message_attachments as ma', 'mm.id', '=', 'ma.message_master_id')
                            ->where('mm.app_user_id',$app_user_id_load_msg)
                            ->select('mm.id as id', 'mm.app_user_id as app_user_id', 'mm.app_user_message as app_user_message', 'mm.admin_id as admin_id', 'mm.admin_message as admin_message','mm.created_at as msg_date', 'ma.admin_atachment as admin_atachment', 'mm.is_attachment as is_attachment', 'ma.attachment_type as attachment_type')
                            ->orderBy('mm.message_date_time', 'desc')
                            ->limit($number_of_msg)
                            ->get();

        $app_user_name = AppUser::select('name','id')
                                    ->where('id', $app_user_id_load_msg)
                                    ->first();
        

        return json_encode(array(
            "message"=>$message,
            "app_user_name"=>$app_user_name,
            //"msg_date"=>$msg_date,
        ));
    }

    ##Search APP Users
    public function searchAppUsers(){
        $search_app_user_name = $_POST['name'];
        $app_users = AppUser::select('id', 'name')
                    ->where('name','like', '%'.$search_app_user_name.'%')
                    ->get();
        return json_encode($app_users);
    }


    public function newMsgSent(Request $r){
        $app_user_id = $r->app_user_id;
        $admin_message = $r->admin_message;
        $admin_id = Auth::user()->id;
        ## Image
        $attachment = $r->file('attachment');

        if($r->hasFile('attachment')){
            $new_msg = new MessageMaster();
            $new_msg->admin_id = $admin_id;
            $new_msg->admin_message = $admin_message;
            $new_msg->app_user_id = $app_user_id;
            $new_msg->is_attachment = 1;
            $new_msg->save();
            $mm_id = $new_msg->id;

            foreach ($attachment as $attachment) {
                $attachment_name = rand().time().$attachment->getClientOriginalName();
                $ext = strtoupper($attachment->getClientOriginalExtension());
                echo $ext;
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
                $msg_attachment->admin_atachment = $attachment_name;
                $msg_attachment->attachment_type = $attachment_type;
                $msg_attachment->save();

                
            }
        }
        else{
            $new_msg = new MessageMaster();
            $new_msg->admin_id = $admin_id;
            $new_msg->admin_message = $admin_message;
            $new_msg->app_user_id = $app_user_id;
            $new_msg->save();
        }
        
        


    }


    
    









}
