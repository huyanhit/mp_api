<?php

namespace App\Http\Requests;

class UserRequest extends BaseRequest
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
            'password' => [
                'required',
                'string',
                'min:8',  // At least 8 characters
                'regex:/[a-z]/',  // At least one lowercase letter
                'regex:/[A-Z]/',  // At least one uppercase letter
                'regex:/[0-9]/',  // At least one digit
                'regex:/[@$!%*?&#]/',  // At least one special character
            ],
            'role_id' => 'required'
        ];
        // Change rules based on the route name
        if ($this->isCreateRoute()) {
            $rules['username'] =  [
                'required',
                'string',
                'max:255',
                'regex:/\w*$/',
                'unique:users,username'
            ];
        }
        if ($this->isUpdateRoute()) {
            $rules['id'] =  [
                'required',
                'exists:users,id',
            ];
        }
        return $rules;
    }

    /**
     * Check if the current route is for creating a user.
     */
    protected function isCreateRoute()
    {
        // Get the current route name
        $routeName = $this->route()->getName();

        // Check if it's a create route
        return $routeName === 'users.create' || $routeName === 'users.store';
    }

     /**
     * Check if the current route is for creating a user.
     */
    protected function isUpdateRoute()
    {
        // Get the current route name
        $routeName = $this->route()->getName();

        // Check if it's a create route
        return $routeName === 'users.update' || $routeName === 'users.edit';
    }
}
