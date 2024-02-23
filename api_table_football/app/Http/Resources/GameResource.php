<?php

namespace App\Http\Resources;

use App\Http\Resources\Team\TeamLiteResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GameResource extends JsonResource
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
            'teamA' => new TeamLiteResource($this->teamHome()),
            'teamB' => new TeamLiteResource($this->teamAway()),
            'teamAScore' => $this->team_a_score,
            'teamBScore' => $this->team_b_score,
            'done' => $this->done,
            'gameDate' => $this->game_date,
        ];
    }
}
