<?php

namespace App\Http\Requests;

class PermissionRequest extends BaseRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return [
            'name_string' => [
                'required',
                'max:255'
            ],
            'description' => [
                'max:255'
            ],
        ];
    }
}
