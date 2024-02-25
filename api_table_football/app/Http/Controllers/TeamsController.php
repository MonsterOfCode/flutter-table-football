<?php

namespace App\Http\Controllers;

use App\Http\Requests\Team\StoreTeamRequest;
use App\Http\Resources\Team\TeamLiteResource;
use App\Http\Resources\Team\TeamResource;
use App\Models\Team;
use App\Models\Player;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class TeamsController extends Controller
{
    /**
     * List of top teams.
     *
     * @return array<TeamLiteResource>
     */
    public function top()
    {
        return TeamLiteResource::collection(Team::getTopTeams());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreTeamRequest $request)
    {

        // Start a transaction
        DB::beginTransaction();

        try {
            $team = Team::create($request->validated());
            $player1 = Player::where('name', '=', $request->player1)->first();
            $player2 = Player::where('name', '=', $request->player2)->first();

            $team->players()->attach([$player1->id, $player2->id]);

            // Commit the transaction
            DB::commit();
            /**
             * A Team resource.
             *
             * @status 201
             * @body TeamResource
             */
            return response()->json(new TeamResource($team), Response::HTTP_CREATED);
        } catch (\Exception $e) {
            // Rollback the transaction
            DB::rollback();
            throw $e;
        }
    }

    /**
     * Search for Teams by name.
     */
    public function search(Request $request)
    {
        $request->validate([
            'query' => 'nullable|string|max:255',
        ]);

        $query = $request->input('query');

        if (!empty($query)) {
            $teams = Team::where('name', 'LIKE', '%' . $query . '%')->get();
        } else {
            $teams = Team::getTopTeams();
        }

        return TeamLiteResource::collection($teams);
    }

    /**
     * Get a Team resource.
     */
    public function show(Team $team)
    {
        return new TeamResource($team);
    }
}
