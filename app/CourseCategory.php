<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CourseCategory extends Model
{
    protected $table = 'course_categories';
    
    protected $fillable = [
        'category_name','status','details',
    ];
}
