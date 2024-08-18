<?php

namespace App\Modules\Chat\Requests;

class UpdateRoomsRequest extends ChatFormRequest
{

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return $this->permission->checkUpdateRoom($this);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return ['name' => 'sometimes | required | max:255', 'members' => 'sometimes | required'];
    }
}