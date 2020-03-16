<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class MessageMaster extends Model
{
    protected $table = 'message_masters';
    
    protected $fillable = [
        'message_id', 'admin_id', 'admin_message', 'app_user_id', 'app_user_message', 'is_seen', 'message_category', 'message_date_time', 'attachment', 'status', 'is_attachment',
    ];
}
