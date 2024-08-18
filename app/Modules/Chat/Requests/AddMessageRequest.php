<?php

namespace App\Modules\Chat\Requests;

class AddMessageRequest extends ChatFormRequest
{

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return $this->permission->checkAuthInRoom($this);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return ['room_id' => 'required|numeric', 'content' => 'required'];
    }
}