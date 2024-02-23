<?php

namespace App\Http\Resources\Game;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class GamesCollection extends ResourceCollection
{
    /**
     * The flag to include or not the teams on the game resource
     *
     * @var boolean
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
        parent::__construct($resource);

        $this->resource = $this->collectResource($resource);
        $this->includeTeams = $includeTeams;
    }

    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request)
    {
        $response = $this->collection->map(function ($game) {
            return new GameResource($game,  $this->includeTeams);
        });
        return $response;
    }
}
