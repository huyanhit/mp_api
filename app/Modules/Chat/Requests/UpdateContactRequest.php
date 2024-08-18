<?php

namespace App\Modules\Chat\Requests;

class UpdateContactRequest extends ChatFormRequest
{

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return $this->permission->checkRoleUpdateUser($this);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return ['user_id' => 'required|numeric', 'name' => 'required | max:255'];
    }
}