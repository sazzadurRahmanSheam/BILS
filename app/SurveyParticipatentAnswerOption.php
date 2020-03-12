<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SurveyParticipatentAnswerOption extends Model
{
    protected $table = 'survey_participant_answer_options';

    protected $fillable = [
        'survey_participant_answer_id','option_id','answer',
    ];
}
