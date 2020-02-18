<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class WebAction extends Model
{
    protected $table = 'web_actions';

    protected $fillable = [
        'activity_name','module_id','status',
    ];
}
