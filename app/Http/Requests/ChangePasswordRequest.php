<?php

namespace App\Http\Requests;

class ChangePasswordRequest extends BaseRequest
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
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */

    public function rules()
    {
        // Base validation rules
        $rules = [
            'current_password' => [
                'required',
                'string',
                'min:8',  // At least 8 characters
                'regex:/[a-z]/',  // At least one lowercase letter
                'regex:/[A-Z]/',  // At least one uppercase letter
                'regex:/[0-9]/',  // At least one digit
                'regex:/[@$!%*?&#]/',  // At least one special character
            ],

            'new_password' => [
                'required',
                'string',
                'min:8',  // At least 8 characters
                'regex:/[a-z]/',  // At least one lowercase letter
                'regex:/[A-Z]/',  // At least one uppercase letter
                'regex:/[0-9]/',  // At least one digit
                'regex:/[@$!%*?&#]/',  // At least one special character
            ]
        ];
        return $rules;
    }
}
