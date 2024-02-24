<?php

namespace App\Http\Resources\Team;

use App\Http\Resources\Player\PlayerLiteResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TeamLiteResource extends JsonResource
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
            'points' => $this->points,
            'players' => PlayerLiteResource::collection($this->players()->get()),
        ];
    }
}
