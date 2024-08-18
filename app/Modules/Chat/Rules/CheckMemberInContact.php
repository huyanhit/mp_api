<?php

namespace App\Modules\Chat\Rules;

use App\Repositories\Chat\ChatRepositoryInterface;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Support\Facades\Auth;

class CheckMemberInContact implements ValidationRule
{
    private ChatRepositoryInterface $chatRepository;
    public function __construct($chatRepository)
    {
        $this->chatRepository = $chatRepository;
    }

    /**
     * Run the validation rule.
     *
     * @param  \Closure(string): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $users = $this->chatRepository->getObject('MY_USER', Auth::id());
        $contacts = $this->chatRepository->getObject('MY_CONTACT', Auth::id());
        $members  = array_merge([Auth::id()], $users['MY_USER'][Auth::id()], $contacts['MY_CONTACT'][Auth::id()]);
        foreach ($value as $member => $role){
            if(!in_array($member, $members)){
                $fail('The ' . $attribute . ' not in contact of user');
            }
        }
    }
}
