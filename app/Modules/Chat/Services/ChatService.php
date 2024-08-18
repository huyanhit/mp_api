<?php

namespace App\Modules\Chat\Services;

use App\Repositories\Chat\ChatRepositoryInterface;

class ChatService {
    protected ChatRepositoryInterface $chatRepository;
    public function __construct(ChatRepositoryInterface $chatRepositoryInterface){
        $this->chatRepository = $chatRepositoryInterface;
    }

    public function getChatRepository(): ChatRepositoryInterface
    {
        return $this->chatRepository;
    }
}
