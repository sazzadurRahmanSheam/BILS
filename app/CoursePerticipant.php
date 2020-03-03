<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CoursePerticipant extends Model
{
    protected $table = 'course_perticipants';

    protected $fillable = [
    	'course_id', 'perticipant_id', 'is_interested', 'is_selected', 'status',
    ];
}
