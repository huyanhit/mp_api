<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PermissionResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [

            'id' => $this->id,
            'name' => $this->name,
            'name_string' => $this->name_string,
            'description' => $this->description,
            'guard_name' => $this->guard_name,
            'module_key' => $this->module_key,
            'module_name' => $this->module_name,
            'sort' => $this->sort,
            'is_active' => $this->is_active,
        ];
    }
}
