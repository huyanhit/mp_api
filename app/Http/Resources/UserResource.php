<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'         => $this->id ?? null,
            'avatar'     => $this->avatar ?? null,
            'username'   => $this->username ?? null,
            'language'   => $this->language ?? null,
            'dark_mode'  => $this->dark_mode ?? null
        ];
    }
}
