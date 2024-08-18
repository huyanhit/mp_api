<?php

namespace App\Modules\Chat\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class CheckModuleRoom implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if (!in_array($value, config('constants.chat.modules'))) {
            $fail('The ' . $attribute . ' not defined in constants!');
        }
    }
}
