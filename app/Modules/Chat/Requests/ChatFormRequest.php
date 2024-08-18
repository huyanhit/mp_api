<?php

namespace App\Modules\Chat\Requests;

use App\Modules\Chat\Services\PermissionService;
use Illuminate\Contracts\Validation\Validator as BaseValidator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Validation\ValidationException;

class ChatFormRequest extends FormRequest
{
    public PermissionService $permission;
    public function __construct(PermissionService $permissionService)
    {
        $this->permission = $permissionService;
        parent::__construct();
    }
}