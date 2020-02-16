<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class App_user_group_member extends Model
{
   protected $table = 'app_user_group_members';
    
    protected $fillable = [
        'app_user_id','group_id','status',
    ];
}
