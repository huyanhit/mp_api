<?php

namespace App\Exceptions;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class AuthorException extends BaseException
{
    public function __construct($exception)
    {
        parent::__construct($exception, Response::HTTP_UNAUTHORIZED);
    }

    /**
     * Render the exception into an HTTP response.
     */
    public function render(Request $request): JsonResponse
    {
        $this->trackingLog($request);
        return $this->jsonResponse();
    }
}
