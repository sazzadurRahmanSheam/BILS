<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class AppUserGroupMember extends Model
{
   protected $table = 'app_user_group_members';
    
    protected $fillable = [
        'app_user_id','group_id','status',
    ];
}
