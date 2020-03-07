<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SurveyQuestionAnswerOption extends Model
{
    //
    protected $table = 'survey_question_answer_options';

    protected $fillable = [
        'survey_question_id','answer_option',
    ];
}
