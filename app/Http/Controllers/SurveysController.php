<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Validator;
use Session;
use DB;
use \App\System;
use \App\User;
use App\Menu;
use Auth;
use App\Traits\HasPermission;
use App\SurveyCategory;
use App\UserGroup;
use App\SurveyMaster;
use App\SurveyQuestion;
use App\SurveyQuestionAnswerOption;
use App\SurveyParticipatentAnswerOption;
use App\SurveyParticipatent;
use App\SurveyParticipatentAnswer;


class SurveysController extends Controller
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
        $data['module_name'] = "Surveys";
        $data['sub_module'] = "";

        // action permissions
        $admin_user_id = Auth::user()->id;
        $add_action_id = 28;
        $add_permisiion = $this->PermissionHasOrNot($admin_user_id, $add_action_id);
        $data['actions']['add_permisiion'] = $add_permisiion;

        return view('survey.index', $data);
    }

    public function getSurveyList(){

        $admin_user_id      = Auth::user()->id;
        $edit_action_id     = 86;
        $delete_action_id   = 87;
        $edit_permisiion    = $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
        $delete_permisiion  = $this->PermissionHasOrNot($admin_user_id,$delete_action_id);

        $survey_list = SurveyMaster::Select('id','survey_name', 'start_date', 'end_date', 'status')
            ->orderBy('id','desc')
            ->get();




        $return_arr = array();
        foreach($survey_list as $data){
            $data['status']=($data->status == 1)?"<button class='btn btn-xs btn-success' disabled>Published</button>":"<button  class='btn btn-xs btn-danger' disabled>Not-published</button>";
            /*
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
*/
            $data['actions']=" <button title='View' onclick='survey_view(".$data->id.",0)' id='view_" . $data->id . "' class='btn btn-xs btn-primary' ><i class='clip-zoom-in'></i></button>";

            $data['actions'].=" <button title='Result' onclick='survey_participant(".$data->id.")' id='view_result" . $data->id . "' class='btn btn-xs btn-primary' ><i class='clip-zoom-in'></i></button>";

            if($edit_permisiion>0){
                $data['actions'] .=" <button title='Serial' onclick='survey_view(".$data->id.",1)' id=edit_serial" . $data->id . "  class='btn btn-xs btn-green' ><i class='clip-list-3'></i></button>";

                $data['actions'] .=" <button title='Edit' onclick='edit_survey(".$data->id.")' id=edit_" . $data->id . "  class='btn btn-xs btn-green' ><i class='clip-pencil-3'></i></button>";
            }
            if ($delete_permisiion>0) {
                $data['actions'] .=" <button title='Delete' onclick='delete_survey(".$data->id.")' id='delete_" . $data->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
            }
            $return_arr[] = $data;
        }
        return json_encode(array('data'=>$return_arr));
    }

    public function surveyParticipantView($id){
        $admin_user_id      = Auth::user()->id;
        $edit_action_id     = 86;
        $delete_action_id   = 87;
        $edit_permisiion    = $this->PermissionHasOrNot($admin_user_id,$edit_action_id);
        $delete_permisiion  = $this->PermissionHasOrNot($admin_user_id,$delete_action_id);

        /*$survey_list = SurveyMaster::Select('id','survey_name', 'start_date', 'end_date', 'status')
            ->orderBy('id','desc')
            ->get();
        */

        $survey_participant = DB::table('survey_participants')
            ->select('survey_participants.id','survey_participants.survey_id','survey_participants.created_at','app_users.name', 'app_users.id as user_id')
            ->join('app_users','app_users.id','=','survey_participants.app_user_id')
            ->where('survey_participants.survey_id','=',$id)
            ->get();
        //echo json_encode($survey); die;
        $survey = SurveyMaster::where('id',$id)->get();
        $surveyQuestion = SurveyQuestion::where('survey_id',$id)->get();
        $surveyQuestion = $surveyQuestion->count();

        $return_arr = array();
        foreach ($survey_participant as $key=>$value){
            $questionAnswer=SurveyParticipatentAnswer::where('survey_participan_id',$value->id)->get();
            $questionAnswer=$questionAnswer->count();
            //echo $questionAnswer;
            $value->question_answered=$questionAnswer;
            $return_arr[]=$value;
        }

        $data['survey']=$survey[0];
        $data['surveyQuestion']=$surveyQuestion;
        $data['surveyParticipant']=$return_arr;

        return json_encode($data);
    }


    public function getSurveyTypes()
    {
        $data = SurveyCategory::select('id', 'category_name')->get();
        return json_encode($data);
    }

    public function getUserGroup()
    {
        $data = UserGroup::select('id', 'group_name')->get();
        return json_encode($data);
    }

    public function surveyBodyEntry(Request $request)
    {
        $rule = [
            'survey_name' => 'Required|max:100',
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
            $return['result'] = "0";
            $return['errors'] = $validation->errors();
            return json_encode($return);
        } else {

            try {
                DB::beginTransaction();
                $status = ($request->is_active == "") ? '0' : '1';

                ##Entry

                $created_by = Auth::user()->id;
                $column_value = [
                    'survey_name' => $request->survey_name,
                    'start_date' => $request->survey_start_date,
                    'end_date' => $request->survey_end_date,
                    'survey_category' => $request->survey_type,
                    'survey_type' => 0,
                    'details' => $request->remarks,
                    'status' => $status,
                    'updated_by' => $created_by,

                ];
                //echo $request->survey_id; die;
                if(isset($request->survey_id) && $request->survey_id!=''){

                    $response = SurveyMaster::where('id','=',$request->survey_id)->update($column_value);

                }else{
                    $column_value['created_by']=$created_by;
                    $response = SurveyMaster::create($column_value);
                }
                DB::commit();
                //echo json_encode($response); die;
                if(isset($response->id)){
                    $return['survey_id'] = $response->id;
                }
                else{
                    $return['survey_id'] =$request->survey_id;
                }
                return json_encode($return);
            } catch (\Exception $e) {
                DB::rollback();
                $return['result'] = "0";
                $return['errors'][] = "Failed to save";
                $return['exception']=$e;
                return json_encode($return);
            }
        }
    }

    public function surveyQuestionEntry(Request $request)
    {
        //echo $request->survey_id;
        //echo $request->serial; die;
        $serial_check = SurveyQuestion::where([['survey_id','=',$request->survey_id],['serial','=',$request->serial]])->get();
        //return json_encode(sizeof($serial_check));

        //echo json_encode($request->all()); die;
        $rule = [
            'survey_id'=> 'Required',
            //'question' => 'Required',
        ];

        $validation = Validator::make($request->all(), $rule);
        if ($validation->fails()) {
            $return['result'] = "0";
            $return['errors'] = $validation->errors();
            return json_encode($return);
        } else {

            try {
                DB::beginTransaction();

                ##Entry

                //$created_by = Auth::user()->id;

                //echo $serial_check;
                //echo $request->question_id;
                //echo $serial_check[0]['id'];

                if($serial_check!=[] ){
                    //echo json_encode($serial_check[0]['id']); die;

                    if(sizeof($serial_check)>1 || (sizeof($serial_check)==1 && !isset($request->question_id)) || (isset($request->question_id) && isset($serial_check[0]['id']) && $serial_check[0]['id']!=$request->question_id)){
                        $return['result'] = "0";
                        $return['errors'][] = "Serial number is not Unique for this survey";
                        $return['exception']='Serial number is not Unique for this survey';
                        return json_encode($return);
                    }
                }



                $column_value = [
                    'question_details' => $request->question,
                    'survey_id' => $request->survey_id,
                    'question_type' => $request->option_type,
                    'serial' => $request->serial,
                    'display_option' => $request->display_option,
                ];
                if(isset($request->question_id) && $request->question_id!=''){
                    $response = SurveyQuestion::where('id',$request->question_id)->update($column_value);
                    $question_id = $request->question_id;

                }
                else{
                    $response = SurveyQuestion::create($column_value);
                    $question_id = $response->id;

                }
                //$data = SurveyQuestion::get();
                //echo json_encode($data); die;

                //return(json_encode($request->input('answer')));

                //echo $request->answer_id[2];die;

                if(isset($request->answer)){
                    $array_index = 0;
                    foreach ($request->input('answer') as $answer_choice){
                        //echo $answer_choice;
                        if($answer_choice!='' && $answer_choice!=' ' && $answer_choice!='.'){
                            $column_value = [
                                'answer_option' => $answer_choice,
                                'survey_question_id' => $question_id,
                            ];

                            if(isset($request->answer_id[$array_index]) && $request->answer_id[$array_index]!=''){
                                if($request->option_type==2 || $request->option_type==1){
                                    //echo 1; die;
                                    SurveyQuestionAnswerOption::where('id',$request->answer_id[$array_index])->delete();
                                }
                                SurveyQuestionAnswerOption::where('id',$request->answer_id[$array_index])->update($column_value);
                            }
                            else{
                                SurveyQuestionAnswerOption::create($column_value);
                            }
                        }
                        $array_index++;
                    }
                }


                //$return['question_id']=$question_id;

                DB::commit();
                return json_encode($response);


            } catch (\Exception $e) {
                DB::rollback();
                $return['result'] = "0";
                $return['errors'][] = "Failed to save";
                $return['exception']=$e;
                return json_encode($return);
            }
        }
    }

    public function surveyEdit($id){

        //echo 3; die();

        $survey = SurveyMaster::where('id','=',$id)->get();

        //echo json_encode($survey); die;
        $data['survey']=$survey[0];

        $question = SurveyQuestion::where('survey_id','=',$id)->orderBy('serial')->get();

        $data['question']=$question;

        return json_encode($data);

    }

    public function surveyDelete($id){
        //echo $id; die;

        try {
            DB::beginTransaction();
            $question = SurveyQuestion::where('survey_id','=',$id)->get();

            foreach ($question as $key=>$value){
                //echo json_encode($value['id']); die;
                SurveyQuestionAnswerOption::where('survey_question_id',$value['id'])->delete();
            }
            SurveyQuestion::where('survey_id','=',$id)->delete();

            SurveyMaster::where('id','=',$id)->delete();

            DB::commit();
            $return['result'] = "1";
            $return['message'][] = "Successfully  Deleted";
            return json_encode($return);
        } catch (\Exception $e) {
            DB::rollback();
            $return['result'] = "0";
            $return['errors'][] = "Failed to Delete";
            $return['exception']=$e;
            return json_encode($return);
        }

    }

    public function questionEdit($id){

        $question =SurveyQuestion ::where('id','=',$id)->get();

        $data['question']=$question[0];

        $question_answer = SurveyQuestionAnswerOption::where('survey_question_id','=',$id)->get();

        $data['question_answer']=$question_answer;

        return json_encode($data);
    }

    public function surveyQuestionSerialize(Request $request){
        //return json_encode($request->survey_id_for_serial);

        $tem_sl = 0;
        foreach ($request->serial as $keys=>$value){
            //echo $request->id[$keys];
            SurveyQuestion::find($request->id[$keys])->update(array('serial' => $value));
        }
        return 1;
    }

    public function questionDelete($id){

        SurveyQuestion::where('id','=',$id)->delete();

        SurveyQuestion::where('survey_id','=',$id)->delete();

        return 1;

    }

    public function answerDelete($id){

        //$question_id =SurveyQuestionAnswerOption::where('id','=',$id)->get();
        SurveyQuestionAnswerOption::where('id','=',$id)->delete();

        //$question_answer = SurveyQuestionAnswerOption::where('survey_question_id','=',$id)->get();

        //$data['question_answer']=$question_answer;
        //echo (json_encode($question_id)); die;
        return 1;

    }

    public function surveyView($id){
        //return 1;
        $survey = SurveyMaster::find($id);
        $data['survey']=$survey;
        $question =SurveyQuestion ::where('survey_id','=',$id)->orderBy('serial')->get();
        //echo json_encode($question);
        foreach ($question as $i=>$values){
            $data['question'][$values['serial']]=$values;
            $data['question'][$values['serial']]['answer'] =SurveyQuestionAnswerOption ::where('survey_question_id','=',$values['id'])->get();
        }
        return json_encode($data);
    }

    public  function surveyParticipantResultView($survey_id,$id){
        $survey_data = $this.surveyView($survey_id);
        return $survey_data;
    }

}
