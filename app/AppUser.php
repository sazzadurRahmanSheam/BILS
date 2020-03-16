<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class AppUser extends Model
{
    protected $table = 'app_users';
    
    protected $fillable = [
        'name','nid_no','email','contact_no','status','address','password','remarks', 'user_profile_image',
    ];
}
