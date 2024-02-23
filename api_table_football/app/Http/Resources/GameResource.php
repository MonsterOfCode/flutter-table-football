<?php

namespace App\Http\Resources;

use App\Http\Resources\Team\TeamLiteResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GameResource extends JsonResource
{
    /**
     * The resource instance.
     *
     * @var bool
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
            'teamAScore' => $this->team_a_score,
            'teamBScore' => $this->team_b_score,
            'done' => $this->done,
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
