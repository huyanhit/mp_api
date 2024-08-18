<?php

namespace App\Modules\Chat\Requests;

class GetRoomRequest extends ChatFormRequest
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
        return ['position'  => 'numeric', 'type' => 'numeric'];
    }
}