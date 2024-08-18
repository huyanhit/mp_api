<?php

namespace App\Modules\Chat\Requests;

class AddContactRequest extends ChatFormRequest
{

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return $this->permission->checkUserInCompany($this);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return ['ids' => 'required'];
    }
}