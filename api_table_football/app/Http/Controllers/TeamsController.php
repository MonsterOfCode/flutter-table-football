<?php

namespace App\Http\Controllers;

use App\Http\Requests\Team\StoreTeamRequest;
use App\Http\Resources\Team\TeamLiteResource;
use App\Http\Resources\Team\TeamResource;
use App\Models\Team;
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
            $team->players()->attach([$request->teamAId, $request->teamBId]);

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
            'query' => 'required|string|max:255',
        ]);

        $query = $request->input('query');

        $teams = Team::where('name', 'LIKE', '%' . $query . '%')->get();

        return TeamLiteResource::collection($teams);
    }

    /**
     * Get a Team resource.
     */
    public function show(Team $team)
    {
        // this never will happens, because is handled in app/Exceptions/Handler.php on render()
        // but is to show on api docs
        if ($team == null) {
            /**
             * A Team resource.
             *
             * @status 404
             * @body array{ error: "Team not found"}
             */
            return response()->json([
                'error' => 'Team not found'
            ], Response::HTTP_NOT_FOUND);
        }

        return new TeamResource($team);
    }
}
