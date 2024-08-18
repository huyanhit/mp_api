<?php

namespace App\Services;

use Illuminate\Auth\Events\Lockout;
use Illuminate\Support\Facades\Auth;
use App\Repositories\User\UserRepositoryInterface;
use App\Http\Resources\UserResource;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class AuthService {
    protected $userRepository;

    public function __construct(UserRepositoryInterface $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    /**
     * Authenticates the user with the given credentials.
     *
     * @param array $credentials The user's login credentials.
     * @return mixed|null The authenticated user if successful, null otherwise.
     * @throws ValidationException
     */

    public function login($request): array
    {
        $this->authenticate($request);
        $user        = Auth::user();
        $tokenResult = $user->createToken('MPERP')->plainTextToken;
        $tokenArray  = explode('|', $tokenResult);
        return [
            'token_id'     => $tokenArray[0],
            'access_token' => $tokenArray[1],
            'token_type'   => 'Bearer',
            'user'         => new UserResource($user),
        ];
    }

    /**
     * Attempt to authenticate the request's credentials.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    private function authenticate($request): void
    {
        $this->ensureIsNotRateLimited($request);
        $credentials = $request->safe()->only(['username', 'password']);
        $credentials['active'] = 1;
        if (! Auth::attempt($credentials, $request->boolean('remember'))) {
            RateLimiter::hit($this->throttleKey($request));
            throw ValidationException::withMessages([
                'email' => __('auth.failed'),
            ]);
        }

        RateLimiter::clear($this->throttleKey($request));
    }

    /**
     * Ensure the login request is not rate limited.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    private function ensureIsNotRateLimited($request): void
    {
        if (! RateLimiter::tooManyAttempts($this->throttleKey($request), 5)) {
            return;
        }

        event(new Lockout($request));
        $seconds = RateLimiter::availableIn($this->throttleKey($request));
        throw ValidationException::withMessages([
            'username' => trans('auth.throttle', [
                'seconds' => $seconds,
                'minutes' => ceil($seconds / 60),
            ]),
        ]);
    }

    /**
     * Get the rate limiting throttle key for the request.
     */
    private function throttleKey($request): string
    {
        return Str::transliterate(Str::lower($request->input('username')).'|'.$request->ip());
    }
}
