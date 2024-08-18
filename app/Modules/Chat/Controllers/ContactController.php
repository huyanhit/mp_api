<?php

namespace App\Modules\Chat\Controllers;

use App\Exceptions\ProcessException;
use App\Http\Controllers\BaseController;
use App\Models\User;
use App\Modules\Chat\Requests\AddContactRequest;
use App\Modules\Chat\Requests\ApproveContactRequest;
use App\Modules\Chat\Requests\CancelContactRequest;
use App\Modules\Chat\Requests\RemoveContactRequest;
use App\Modules\Chat\Requests\UnRequestContactRequest;
use App\Modules\Chat\Services\ContactService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ContactController extends BaseController {
    private ContactService $contactService;
    public function __construct(ContactService $contactService){
        $this->contactService = $contactService;
    }

    public function approve(ApproveContactRequest $request):JsonResponse
    {
        try {
            return $this->sendResponse($this->contactService->approve($request->input()));
        }catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function cancel(CancelContactRequest $request):JsonResponse
    {
        try {
            return $this->sendResponse($this->contactService->cancel($request->input()));
        }catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function unRequest(UnRequestContactRequest $request):JsonResponse
    {
        try {
            return $this->sendResponse($this->contactService->unRequest($request->input()));
        }catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function remove(RemoveContactRequest $request):JsonResponse
    {
        try {
            return $this->sendResponse($this->contactService->remove($request->input()));
        }catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function store(AddContactRequest $request):JsonResponse
    {
        try {
            return $this->sendResponse($this->contactService->addContact($request->input()));
        }catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function getUser($type):JsonResponse
    {
        try {
            return $this->sendResponse($this->contactService->getUser($type));
        }catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function index():JsonResponse
    {
        try {
            return $this->sendResponse($this->contactService->getAllContact(Auth::id()));
        }catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function getAllGuest():JsonResponse
    {
        try {
            return $this->sendResponse($this->contactService->getAllGuest());
        }catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }

    public function show(Request $request, $user):JsonResponse
    {
        try {
            return $this->sendResponse(['USER' => [$user => User::find($user)]]);
        }catch (\Exception $e) {
            throw new ProcessException($e);
        }
    }
}
