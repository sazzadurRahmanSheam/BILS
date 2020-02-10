<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Publication_category extends Model
{
    protected $table = 'publication_categories';
    
    protected $fillable = [
        'category_name','status','details',
    ];
}
