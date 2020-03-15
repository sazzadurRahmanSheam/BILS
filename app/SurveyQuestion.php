<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SurveyQuestion extends Model
{
    //
    protected $table = 'survey_questions';

    protected $fillable = [
        'survey_id','question_details','question_type','serial','display_option',
    ];
}
