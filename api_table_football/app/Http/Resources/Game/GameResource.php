<?php

namespace App\Http\Resources\Game;

use App\Http\Resources\Team\TeamLiteResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GameResource extends JsonResource
{
    /**
     * The resource instance.
     */
    protected $includeTeams;

    /**
     * Create a new resource instance.
     *
     * @param  mixed  $resource
     * @return void
     */
    public function __construct($resource, $includeTeams = true)
    {
        $this->resource = $resource;
        $this->includeTeams = $includeTeams;
    }


    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $response = [
            'id' => $this->id,
            'scoreTeamA' => $this->team_a_score,
            'scoreTeamB' => $this->team_b_score,
            'done' => $this->done == 1,
            'gameDate' => $this->game_date,
        ];

        if ($this->includeTeams) {
            $response += [
                'teamA' => new TeamLiteResource($this->teamHome),
                'teamB' => new TeamLiteResource($this->teamAway),
            ];
        }

        return $response;
    }
}
