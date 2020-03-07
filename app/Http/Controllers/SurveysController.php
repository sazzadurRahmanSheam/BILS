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
            $data['actions']=" <button title='View' onclick='survey_view(".$data->id.")' id='view_" . $data->id . "' class='btn btn-xs btn-primary' ><i class='clip-zoom-in'></i></button>";

            if($edit_permisiion>0){
                $data['actions'] .=" <button title='Edit' onclick='edit_survey(".$data->id.")' id=edit_" . $data->id . "  class='btn btn-xs btn-green' ><i class='clip-pencil-3'></i></button>";
            }
            if ($delete_permisiion>0) {
                $data['actions'] .=" <button title='Delete' onclick='delete_survey(".$data->id.")' id='delete_" . $data->id . "' class='btn btn-xs btn-danger' ><i class='clip-remove'></i></button>";
            }
            $return_arr[] = $data;
        }
        return json_encode(array('data'=>$return_arr));
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
                $column_value = [
                    'question_details' => $request->question,
                    'survey_id' => $request->survey_id,
                    'question_type' => $request->option_type,
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

        $question = SurveyQuestion::where('survey_id','=',$id)->get();

        $data['question']=$question;

        /*
         $perticipantsList = DB::table('survey_questions as sq')
            ->leftJoin('survey_question_answer_options as sqao', 'sqao.survey_question_id', '=', 'sq.id')
            ->where('sq.survey_id', $id)
            ->select('sq.question_details as question', 'sq.question_type as type', 'sq.id as question_id',
                'sqao.answer_option as answer', 'sqao.id as answer_id')
            ->get();
        */


        return json_encode($data);

    }

    public function questionEdit($id){

        $question = SurveyQuestion::where('id','=',$id)->get();

        $data['question']=$question[0];

        $question_answer = SurveyQuestionAnswerOption::where('survey_question_id','=',$id)->get();

        $data['question_answer']=$question_answer;

        return json_encode($data);
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



}
