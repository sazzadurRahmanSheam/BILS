<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class App_user extends Model
{
    protected $table = 'app_users';
    
    protected $fillable = [
        'name','nid_no','email','contact_no','address',
    ];
}
