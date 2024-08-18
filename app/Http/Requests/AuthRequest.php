<?php

namespace App\Http\Requests;

class AuthRequest extends BaseRequest
{

    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */

    public function rules(): array
    {
        return [
            'username' => 'required|max:255',
            'password' => 'required|max:255',
        ];
    }
}
