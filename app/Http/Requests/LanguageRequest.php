<?php

namespace App\Http\Requests;

use Illuminate\Validation\Rule;

class LanguageRequest extends BaseRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return auth()->check();
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
            'language' => [
                'required',
                'string',
                Rule::in(['vi','ja','en'])
            ]
        ];
        return $rules;
    }
}
