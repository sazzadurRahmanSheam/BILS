<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class User_group extends Model
{
    protected $table = 'user_groups';

    protected $fillable = [
        'group_name','type','status',
    ];
}
