<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
	protected $table = 'notifications';
    
    protected $fillable = [
        'from_id', 'from_user_type', 'to_id', 'to_user_type', 'date_time', 'notification_title', 'message', 'status', 'view_url',
    ];
}
