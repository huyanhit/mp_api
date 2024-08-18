<?php

namespace App\Exceptions;

use App\Helpers\Helper;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class UploadException extends BaseException
{
    public function __construct($exception)
    {
        parent::__construct($exception, Response::HTTP_NOT_FOUND);
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
