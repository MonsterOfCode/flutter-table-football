<?php

namespace App\Http\Controllers;

use App\Http\Requests\Player\StorePlayerRequest;
use App\Http\Resources\Player\PlayerLiteResource;
use App\Http\Resources\Player\PlayerResource;
use App\Http\Resources\Team\TeamLiteResource;
use App\Models\Player;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class PlayersController extends Controller
{
    /**
     * Check if a nickname is available for new player.
     */
    public function checkNickname(Request $request)
    {

        $request->validate([
            /**
             * The player nickname.
             * @var string
             */
            'name' => 'required|string|max:255|unique:players,name',
        ]);

        /**
         * A Player resource.
         *
         * @status 200
         * @body array{ message: "Success"}
         */
        return response()->json([
            'message' => 'Success',
        ], Response::HTTP_OK);
    }



    /**
     * List of top players.
     *
     * @return array<PlayerResource>
     */
    public function top()
    {
        return PlayerResource::collection(Player::getTopPlayers());
    }

    /**
     * List of top teams player.
     *
     * @return array<TeamLiteResource>
     */
    public function topTeams(Player $player)
    {
        return TeamLiteResource::collection($player->topTeams());
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(StorePlayerRequest $request)
    {

        // Start a transaction
        DB::beginTransaction();

        try {
            $player = Player::create($request->validated());

            // Commit the transaction
            DB::commit();
            /**
             * A Player resource.
             *
             * @status 201
             * @body PlayerResource
             */
            return response()->json(new PlayerResource($player), Response::HTTP_CREATED);
        } catch (\Exception $e) {
            // Rollback the transaction
            DB::rollback();
            throw $e;
        }
    }


    /**
     * Search for players by name.
     */
    public function search(Request $request)
    {
        $request->validate([
            /**
             * The string to be used on query.
             * @var string
             */
            'query' => 'nullable|string|max:255',
        ]);

        $query = $request->input('query');

        if (!empty($query)) {
            $players = Player::where('name', 'LIKE', '%' . $query . '%')->get();
        } else {
            $players = Player::getTopPlayers();
        }


        return PlayerLiteResource::collection($players);
    }

    /**
     * Get a Player resource by nickname.
     */
    public function show(Player $player)
    {
        return new PlayerResource($player);
    }
}
