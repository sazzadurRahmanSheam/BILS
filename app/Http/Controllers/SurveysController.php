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
use App\SueveyMaster;
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
                    'created_by' => $created_by,
                    'updated_by' => $created_by,

                ];
                $response = SueveyMaster::create($column_value);
                DB::commit();
                $return['survey_id'] = $response->id;
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
                $response = SurveyQuestion::create($column_value);
                //$data = SurveyQuestion::get();
                //echo json_encode($data); die;
                $question_id = $response->id;

                //return(json_encode($request->input('answer')));


                foreach ($request->input('answer') as $answer_choice){
                    //echo $answer_choice;
                    if($answer_choice!='' && $answer_choice!=' ' && $answer_choice!='.'){
                        $column_value = [
                            'answer_option' => $answer_choice,
                            'survey_question_id' => $question_id,
                        ];
                        SurveyQuestionAnswerOption::create($column_value);
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



}
