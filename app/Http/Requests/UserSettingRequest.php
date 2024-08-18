<?php

namespace App\Http\Requests;

use Illuminate\Validation\Rule;

class UserSettingRequest extends BaseRequest
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
        $rules['columns'] = 'required';
        if($this->columns){
            foreach (config('constants.setting_columns') as $column){
                if(in_array($column, $this->columns)){
                    
                }
                $rules[$column] = 'nullable';
            }
        }
        return $rules;
    }
}
