<?php

namespace App\Http\Resources\Player;

use App\Http\Resources\Team\TeamLiteResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PlayerResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'name' => $this->name,
            'points' => $this->points,
            'wins' => $this->wins,
            'losses' => $this->losses,
            'goalsFor' => $this->goalsFor,
            'goalsAgainst' => $this->goalsAgainst,
            'topTeams' => TeamLiteResource::collection($this->topTeams()),
        ];
    }
}
