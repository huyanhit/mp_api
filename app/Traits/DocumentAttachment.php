<?php

namespace App\Traits;

use App\Models\Document\DocumentAttach;

Trait DocumentAttachment
{
    public function documentAttachs()
    {
        return  $this->morphMany(DocumentAttach::class, 'document_attachable');
    }
}
