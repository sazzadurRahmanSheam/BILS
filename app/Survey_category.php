<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Survey_category extends Model
{
    protected $table = 'survey_categories';
    
    protected $fillable = [
        'category_name','status','details',
    ];
}
