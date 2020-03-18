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
        $data['sub_module']= "Manage Courses";
        // action permissions
        $admin_user_id  = Auth::user()->id;
        $add_action_id  = 26;
        $publish_course_action_id  = 92;
        $select_perticipant_action_id  = 93;
        $add_permisiion = $this->PermissionHasOrNot($admin_user_id,$add_action_id );
        $publish_course_permisiion = $this->PermissionHasOrNot($admin_user_id,$publish_course_action_id );
        $select_perticipant_permisiion = $this->PermissionHasOrNot($admin_user_id,$select_perticipant_action_id );
        $data['actions']['add_permisiion']= $add_permisiion;
        $data['actions']['publish_course_permisiion']= $publish_course_permisiion;
        $data['actions']['select_perticipant_permisiion']= $select_perticipant_permisiion;
        return view('courses.index', $data);
    }

    public function getCategories(){
        $data = CourseCategory::select('id','category_name')->get();
        return json_encode($data);
    }

    //Course Entry And Update
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
                        'course_status'=>$request->course_status,
                        'payment_fee'=>$request->payment_fee,
                        'payment_method'=>$request->payment_method,
                        'course_teacher'=>$request->course_teacher,
                        'discount_message'=>$request->discount_message,
                    ];

                   

                    $data_check = CourseMaster::find($request->course_edit_id);

                    if($data_check['pub_status']!='1'){
                        ##Publish Notification
                        if($pub_status=='1'){
                            $course_id = $request->course_edit_id;
                            $user_id = AppUser::select('id')->get();
                            foreach($user_id as $perticipant_id){
                                $column_value2 = [
                                    'course_id'=>$course_id,
                                    'perticipant_id'=>$perticipant_id['id'],
                                    'is_interested'=>0,
                                ];
                                $res = CoursePerticipant::create($column_value2);

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
                     }


                    
                    $data = CourseMaster::find($request->course_edit_id);
                    $data->update($column_value);




                    if($data_check['course_status']!='2'){

                        if ($request->course_status=='2') {     ##Approve Course

                            $Interested_user_id = CoursePerticipant::select('perticipant_id')
                                                ->where('is_interested','1')
                                                ->get();
                            foreach($Interested_user_id as $Interested_user_id){
                                ##Notification Entry
                                $column_value4 = [
                                    'from_id'=>$from_id,
                                    'from_user_type'=>$from_user_type,
                                    'to_id'=>$Interested_user_id['perticipant_id'],
                                    'to_user_type'=>$to_user_type,
                                    'notification_title'=>'BILS Approved '.$request->course_title.' Course',
                                    'view_url'=>'course/'.$request->course_edit_id,
                                    
                                ];
                                $res2 = Notification::create($column_value4);
                            }
                        }
                    }

                    if($data_check['course_status']!='3'){

                        if ($request->course_status=='3') {     ##Rejected Course

                            $Interested_user_id = CoursePerticipant::select('perticipant_id')
                                                ->where('is_interested','1')
                                                ->get();
                            foreach($Interested_user_id as $Interested_user_id){
                                ##Notification Entry
                                $column_value4 = [
                                    'from_id'=>$from_id,
                                    'from_user_type'=>$from_user_type,
                                    'to_id'=>$Interested_user_id['perticipant_id'],
                                    'to_user_type'=>$to_user_type,
                                    'notification_title'=>'BILS Rejected '.$request->course_title.' Course',
                                    'view_url'=>'course/'.$request->course_edit_id,
                                    
                                ];
                                $res2 = Notification::create($column_value4);
                            }
                        }
                    }

                    if($data_check['course_status']!='4'){

                        if ($request->course_status=='4') {     ##Started Course

                            $Interested_user_id = CoursePerticipant::select('perticipant_id')
                                                ->where('is_interested','1')
                                                ->get();
                            foreach($Interested_user_id as $Interested_user_id){
                                ##Notification Entry
                                $column_value4 = [
                                    'from_id'=>$from_id,
                                    'from_user_type'=>$from_user_type,
                                    'to_id'=>$Interested_user_id['perticipant_id'],
                                    'to_user_type'=>$to_user_type,
                                    'notification_title'=>'BILS Started '.$request->course_title.' Course',
                                    'view_url'=>'course/'.$request->course_edit_id,
                                    
                                ];
                                $res2 = Notification::create($column_value4);
                            }
                        }
                    }

                    if($data_check['course_status']!='5'){

                        if ($request->course_status=='5') {     ##Completed Course

                            $Interested_user_id = CoursePerticipant::select('perticipant_id')
                                                ->where('is_interested','1')
                                                ->get();
                            foreach($Interested_user_id as $Interested_user_id){
                                ##Notification Entry
                                $column_value4 = [
                                    'from_id'=>$from_id,
                                    'from_user_type'=>$from_user_type,
                                    'to_id'=>$Interested_user_id['perticipant_id'],
                                    'to_user_type'=>$to_user_type,
                                    'notification_title'=>'BILS Completed '.$request->course_title.' Course',
                                    'view_url'=>'course/'.$request->course_edit_id,
                                    
                                ];
                                $res2 = Notification::create($column_value4);
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
            
            $data['actions']=" <button title='View' onclick='course_view(".$data->id.")' id='view_" . $data->id . "' class='btn btn-xs btn-primary' ><i class='clip-zoom-in'></i></button>";

            if($edit_permisiion>0){
                $data['actions'] .=" <button title='Edit' onclick='edit_course(".$data->id.")' id=edit_" . $data->id . "  class='btn btn-xs btn-green' ><i class='clip-pencil-3'></i></button>";
            }
            if ($delete_permisiion>0) {
                $data['actions'] .=" <button title='Delete' onclick='delete_course(".$data->id.")' id='delete_" . $data->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
            }
            $return_arr[] = $data;
        }
        return json_encode(array('data'=>$return_arr));
    }

    //Course view
    public function courseView($id){
        $data = CourseMaster::find($id);
        return json_encode($data);
    }

    //Course edit data
    public function courseEdit($id){
        $data = CourseMaster::find($id);
        return json_encode($data);
    }


     //Course Delete
    public function courseDelete($id){
        Notification::where('view_url','=','course/'.$id)->delete();
        CoursePerticipant::where('course_id',$id)->delete();
        CourseMaster::find($id)->delete();
        return json_encode(array(
            "deleteMessage"=>"Deleted Successful"
        ));
    }


    public function interestedPerticipantsList($c_id){
        $perticipantsList = DB::table('course_perticipants as cp')
                            ->leftJoin('app_users as au', 'cp.perticipant_id', '=', 'au.id')
                            ->where('cp.course_id', $c_id)
                            ->whereIn('cp.is_interested', ['1','3'])
                            ->select('au.name as name', 'au.email as email', 'au.contact_no as mobile', 'cp.id as cp_id', 'cp.is_selected as is_selected')
                            ->get();

        $registeredList = DB::table('course_perticipants as cp')
                            ->leftJoin('app_users as au', 'cp.perticipant_id', '=', 'au.id')
                            ->where('cp.course_id', $c_id)
                            ->where('cp.is_interested', '3')
                            ->select('au.name as name', 'au.email as email', 'au.contact_no as mobile', 'cp.id as cp_id', 'cp.is_selected as is_selected')
                            ->get();

        $selectedList = DB::table('course_perticipants as cp')
                            ->leftJoin('app_users as au', 'cp.perticipant_id', '=', 'au.id')
                            ->where('cp.course_id', $c_id)
                            ->where('cp.is_selected', '1')
                            ->select('au.name as name', 'au.email as email', 'au.contact_no as mobile', 'cp.id as cp_id', 'cp.is_selected as is_selected')
                            ->get();




        $perticipantTotal = DB::table('course_perticipants as cp')
                            ->leftJoin('app_users as au', 'cp.perticipant_id', '=', 'au.id')
                            ->where('cp.course_id', $c_id)
                            ->whereIn('cp.is_interested', ['1','3'])
                            ->select('au.name as name', 'au.email as email', 'au.contact_no as mobile')
                            ->count();

        $registerTotal = DB::table('course_perticipants as cp')
                            ->leftJoin('app_users as au', 'cp.perticipant_id', '=', 'au.id')
                            ->where('cp.course_id', $c_id)
                            ->where('cp.is_interested', '3')
                            ->select('au.name as name', 'au.email as email', 'au.contact_no as mobile')
                            ->count();

        $selectedTotal = DB::table('course_perticipants as cp')
                            ->leftJoin('app_users as au', 'cp.perticipant_id', '=', 'au.id')
                            ->where('cp.course_id', $c_id)
                            ->where('cp.is_selected', '1')
                            ->select('au.name as name', 'au.email as email', 'au.contact_no as mobile')
                            ->count();



                          
        return json_encode(array(
            "perticipantsList"=>$perticipantsList,
            "registeredList"=>$registeredList,
            "selectedList"=>$selectedList,

            "perticipantTotal"=>$perticipantTotal,
            "registerTotal"=>$registerTotal,
            "selectedTotal"=>$selectedTotal
        ));

    }


    ##Save Selected Person
    public function saveSelectedPerson(Request $req){
        $selected_person = $req->input('selected_person');
        if (isset($selected_person)&&$selected_person!="") {
            foreach($selected_person as $selected_person){
                $data = CoursePerticipant::find($selected_person);
                $data->update(['is_selected' => 1]);
            }
        }
        return '<div class="alert alert-success alert-dismissible">
    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    <strong>Participants Selected!</strong>successfully.
  </div>';
    }

    ##Save Remove Person
    public function saveRemovePerson(Request $req){
        $remove_person = $req->input('remove_person');
        if (isset($remove_person)&&$remove_person!="") {
            foreach($remove_person as $remove_person){
                $data = CoursePerticipant::find($remove_person);
                $data->update(['is_selected' => 0]);
            }
        }
        return '<div class="alert alert-danger alert-dismissible">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Participants Removed!</strong>.
                </div>';
    }

    public function getTeacher(){
        $data = Teacher::select('name')->get();
        return json_encode($data);
    }

    /* ----- Report ----- */
    public function courseSummery(){
        $data['page_title'] = $this->page_title;
        $data['module_name'] = "Reports";
        $data['sub_module'] = "Course Summary";

        return view('reports.course_summary', $data);
    }

    public function getCourseSummery(Request $request){
        
        $summary_data = CourseMaster::whereBetween('appx_start_time',[$request->date_from, $request->date_to])->get();

        $data=[];
        foreach ( $summary_data as $key=>$value){
            $interested = CoursePerticipant::where('course_id','=',$value->id)
                        ->whereIn('is_interested',[1,3])
                        ->count();
            $value['interested']=$interested;
           
            $data[]=$value;
        }
        $userName = Auth::User()->name;
        $data['user']=$userName;

        return json_encode($data);
    }

    public function getCourseDetails(){
        $data['page_title'] = $this->page_title;
        $data['module_name'] = "Reports";
        $data['sub_module'] = "Course Details";

        return view('reports.course_details', $data);
    }

    public function getCourseNameAutoComplete(){
        $course_name_code = $_REQUEST['term'];

        $data = CourseMaster::select('id', 'course_code', 'course_title')
            ->where('course_title','like','%'.$course_name_code.'%')
            ->orwhere('course_code','like','%'.$course_name_code.'%')
            ->get();
        $data_count = $data->count();

        if($data_count>0){
            foreach ($data as $row) {
                $json[] = array('id' => $row["id"],'label' => $row["course_code"].'->'.$row["course_title"]);
            }
        }
        else {
            $json[] = array('id' => "0",'label' => "Not Found !!!");
        }
        return json_encode($json);
    }











}