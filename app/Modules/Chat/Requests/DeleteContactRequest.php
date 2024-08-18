<?php

namespace App\Modules\Chat\Requests;

class DeleteContactRequest extends ChatFormRequest
{

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return $this->permission->checkRoleDeleteUser($this);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return ['user_id' => 'required|numeric'];
    }
}