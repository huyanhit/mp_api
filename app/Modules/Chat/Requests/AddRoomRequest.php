<?php

namespace App\Modules\Chat\Requests;

use App\Modules\Chat\Rules\CheckMemberInContact;
use App\Modules\Chat\Services\PermissionService;
use App\Repositories\Chat\ChatRepositoryInterface;

class AddRoomRequest extends ChatFormRequest
{
    private ChatRepositoryInterface $chatRepository;

    public function __construct(ChatRepositoryInterface $chatRepository, PermissionService $permissionService)
    {
        $this->chatRepository = $chatRepository;
        parent::__construct($permissionService);
    }

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return [
            'name' => 'required | max:255',
            'members' => new CheckMemberInContact($this->chatRepository)
        ];
    }
}