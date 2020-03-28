<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CourseMaster extends Model
{
    protected $table = 'course_masters';
    
    protected $fillable = [
        'course_title', 'duration', 'appx_start_time', 'appx_end_time', 'act_start_time', 'act_end_time', 'course_type', 'course_teacher', 'course_responsible_person', 'details', 'course_status', 'payment_fee', 'payment_method', 'discount_message', 'attachment', 'pub_status', 'created_by', 'updated_by', 'course_code', 'perticipants_limit',
    ];
}
