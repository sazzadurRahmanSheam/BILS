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

class CoursesController extends Controller
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
        $data['sub_module']= "Open Courses";
        // action permissions
        $admin_user_id  = Auth::user()->id;
        $add_action_id  = 26;
        $add_permisiion = $this->PermissionHasOrNot($admin_user_id,$add_action_id );
        $data['actions']['add_permisiion']= $add_permisiion;
        return view('courses.index', $data);
    }

    public function getCategories(){
        $data = CourseCategory::select('id','category_name')->get();
        return json_encode($data);
    }

    //Notice Entry And Update
    public function courseEntryUpdate(Request $request){ 
        $rule = [
            'course_title' => 'Required|max:100',
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
            $return['result'] = "0";
            $return['errors'] = $validation->errors();
            return json_encode($return);
        }
        else{

            /*----- For notification -----*/
            $from_id = Auth::user()->id;
            $from_user_type = 'Admin';
            $to_user_type = 'App User';
            /*----- For notification -----*/
            
            
                
            try{
                DB::beginTransaction();
                $pub_status = ($request->pub_status =="")?'0':'1';

                ##Entry
                if ($request->course_edit_id == '') {
                    $created_by = Auth::user()->name;
                    $column_value = [
                        'course_title'=>$request->course_title,
                        'details'=>$request->details,
                        'duration'=>$request->duration,  
                        'course_type'=>$request->course_type,   
                        'appx_start_time'=>$request->appx_start_time,   
                        'appx_end_time'=>$request->appx_end_time,   
                        'act_start_time'=>$request->act_start_time,   
                        'act_end_time'=>$request->act_end_time,   
                        'created_by'=>$created_by,
                        'pub_status'=>$pub_status,
                        'course_status'=>1,
                        'payment_fee'=>$request->payment_fee,
                        'payment_method'=>$request->payment_method,
                        'course_teacher'=>$request->course_teacher,
                        'discount_message'=>$request->discount_message,
                    ];
                    $response = CourseMaster::create($column_value);

                    if($pub_status=='1'){
                        $course_id = $response->id;
                        $user_id = AppUser::select('id')->get();
                        foreach($user_id as $perticipant_id){
                            $column_value = [
                                'course_id'=>$course_id,
                                'perticipant_id'=>$perticipant_id['id'],
                                'is_interested'=>0,
                            ];
                            $res = CoursePerticipant::create($column_value);

                            ##Notification Entry
                            $column_value1 = [
                                'from_id'=>$from_id,
                                'from_user_type'=>$from_user_type,
                                'from_user_type'=>$from_user_type,
                                'to_id'=>$perticipant_id['id'],
                                'to_user_type'=>$to_user_type,
                                'notification_title'=>'BILS Initiate '.$request->course_title.' Course',
                                'view_url'=>'course/'.$course_id,
                            ];
                            $res1 = Notification::create($column_value1);
                        }
                    }
                    
                    /*if (isset($app_user_group)&& $app_user_group!="") {
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
                    }*/


                }
                ##Update
                else{
                    $updated_by = Auth::user()->name;
                    $column_value = [
                        'course_title'=>$request->course_title,
                        'details'=>$request->details,
                        'duration'=>$request->duration,  
                        'course_type'=>$request->course_type,   
                        'appx_start_time'=>$request->appx_start_time,   
                        'appx_end_time'=>$request->appx_end_time,   
                        'act_start_time'=>$request->act_start_time,   
                        'act_end_time'=>$request->act_end_time,   
                        'updated_by'=>$updated_by,
                        'pub_status'=>$pub_status,
                    ];

                    $data = CourseMaster::find($request->course_edit_id);
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

    //Course List
    public function getCourseList(){

        $admin_user_id      = Auth::user()->id;
        $edit_action_id     = 76;
        $delete_action_id   = 77;
        $edit_permisiion    = $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
        $delete_permisiion  = $this->PermissionHasOrNot($admin_user_id,$delete_action_id);

        $message_list = CourseMaster::Select('id', 'course_title', 'duration', 'pub_status','course_status')
                        ->orderBy('id','desc')
                        ->get();
        $return_arr = array();
        foreach($message_list as $data){ 
            $data['pub_status']=($data->pub_status == 1)?"<button class='btn btn-xs btn-success' disabled>Published</button>":"<button  class='btn btn-xs btn-danger' disabled>Not-published</button>";       
            if($data->course_status==1){
                $data['course_status'] = "<button class='btn btn-xs btn-warning' disabled>Initiate</button>";
            }
            else if($data->course_status==2){
                $data['course_status'] = "<button class='btn btn-xs btn-success' disabled>Approved</button>";
            }
            else if($data->course_status==3){
                $data['course_status'] = "<button class='btn btn-xs btn-danger' disabled>Rejected</button>";
            }
            else if($data->course_status==4){
                $data['course_status'] = "<button class='btn btn-xs btn-info' disabled>Started</button>";
            }
            else if($data->course_status==5){
                $data['course_status'] = "<button class='btn btn-xs btn-success' disabled>Completed</button>";
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











}