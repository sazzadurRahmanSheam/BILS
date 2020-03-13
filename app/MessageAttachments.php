<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class MessageAttachments extends Model
{
    protected $table = 'message_attachments';
    
    protected $fillable = [
        'message_master_id', 'admin_atachment', 'app_user_attachment',
    ];
}
