<?php

namespace App\Modules\Chat\Requests;

use App\Modules\Chat\Rules\CheckMemberInContact;
use App\Modules\Chat\Rules\CheckModuleRoom;
use App\Modules\Chat\Services\PermissionService;
use App\Repositories\Chat\ChatRepositoryInterface;

class AddModuleRoomRequest extends ChatFormRequest
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
            'object_id' => 'required',
            'module'  => new CheckModuleRoom(),
            'members' => new CheckMemberInContact($this->chatRepository)
        ];
    }
}