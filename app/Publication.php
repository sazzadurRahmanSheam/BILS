<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Publication extends Model
{
    protected $table = 'publications';
    
    protected $fillable = [
        'publication_title', 'details', 'publication_type', 'authors', 'created_by', 'updated_by', 'status',
    ];
}
