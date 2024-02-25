<?php

namespace App\Http\Resources\Team;

use App\Http\Resources\Game\GamesCollection;
use App\Http\Resources\Player\PlayerLiteResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TeamResource extends JsonResource
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
            'points' => $this->points ?? 0,
            'wins' => $this->wins ?? 0,
            'losses' => $this->losses ?? 0,
            'goalsFor' => $this->goals_for ?? 0,
            'goalsAgainst' => $this->goals_against ?? 0,
            'players' => PlayerLiteResource::collection($this->players()->get()),
            'lastGames' => new GamesCollection($this->lastGames()),
        ];
    }
}
