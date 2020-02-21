<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Notice extends Model
{
   protected $table = 'notices';
    
    protected $fillable = [
        'title','details','notice_date','attachment','expire_date','status','created_by','updated_by',
    ];
}
