<?php

namespace App\Traits;

use App\Models\Tag\Tag;

trait TagModule
{
    # tagModule được khai báo ở model sử dụng tính năng Tag
    public function tags()
    {
        return $this->belongsToMany(Tag::class, 'tags_modules', 'object_id')->wherePivot('module', $this->tagModule);
    }
}
