<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PublicationCategory extends Model
{
    protected $table = 'publication_categories';
    
    protected $fillable = [
        'category_name','status','details',
    ];
}
