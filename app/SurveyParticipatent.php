<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SurveyParticipatent extends Model
{
    protected $table = 'survey_participants';

    protected $fillable = [
        'app_user_id','survey_id','answer_date','survey_completed',
    ];
}
