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
            'points' => $this->points,
            'wins' => $this->wins,
            'losses' => $this->losses,
            'goalsFor' => $this->goals_for,
            'goalsAgainst' => $this->goals_against,
            'players' => PlayerLiteResource::collection($this->players()->get()),
            'lastGames' => new GamesCollection($this->lastGames(), false),
        ];
    }
}
