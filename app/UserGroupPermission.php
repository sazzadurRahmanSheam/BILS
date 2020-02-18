<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UserGroupPermission extends Model
{
    protected $table = 'user_group_permissions';

    protected $fillable = [
        'group_id','action_id','status',
    ];
}
