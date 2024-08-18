<?php

namespace App\Modules\Chat\Controllers;

use App\Http\Controllers\BaseController;
use App\Modules\Chat\Services\ReactionService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ReactionController extends BaseController {
    private ReactionService $reactionService;
    public function __construct(ReactionService $reactionService){
        $this->reactionService = $reactionService;
    }

    public function store(Request $request): JsonResponse
    {
        return $this->sendResponse($this->reactionService->addReaction($request->input()));
    }
}
