<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Notice_category extends Model
{
    protected $table = 'notice_categories';
    
    protected $fillable = [
        'category_name','status','details',
    ];
}
