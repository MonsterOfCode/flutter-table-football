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
            'points' => $this->points ?? 0,
            'wins' => $this->wins ?? 0,
            'losses' => $this->losses ?? 0,
            'goalsFor' => $this->goals_for ?? 0,
            'goalsAgainst' => $this->goals_against ?? 0,
            'topTeams' => TeamLiteResource::collection($this->topTeams()),
        ];
    }
}
