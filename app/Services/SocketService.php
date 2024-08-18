<?php

namespace App\Services;

use App\Modules\Chat\Services\ChatService;
use ElephantIO\Client;
class SocketService{

    const URL_SOCKET = 'http://localhost:8081';
    const KEY_SOCKET = '761148';
    protected Client $client;

    public function send($data): void
    {
        $this->connect();
        $this->client->emit('push-socket', $data);
        $this->disconnect();
    }

    public function connect():void
    {
        $options = [
            'client' => Client::CLIENT_4X,
            'headers' => [
                'Authorization' => self::KEY_SOCKET,
            ],
        ];
        $this->client = Client::create(self::URL_SOCKET, $options)->connect();
    }

    public function emit($data): void
    {
        $this->client->emit('push-socket', $data);
    }

    public function disconnect(): void
    {
        $this->client->disconnect();
    }
}
