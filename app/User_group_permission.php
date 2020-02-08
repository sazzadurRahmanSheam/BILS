<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class User_group_permission extends Model
{
    protected $table = 'user_group_permissions';

    protected $fillable = [
        'group_id','action_id','status',
    ];
}
