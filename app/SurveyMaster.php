<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SurveyMaster extends Model
{
    //
    protected $table = 'survey_masters';

    protected $fillable = [
        'survey_name','start_date','end_date','survey_category','survey_type','details','status','created_by','updated_by',
    ];
}
