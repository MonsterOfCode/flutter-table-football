<?php

namespace App\Http\Controllers;

use App\Http\Requests\Player\StorePlayerRequest;
use App\Http\Resources\Player\PlayerLiteResource;
use App\Http\Resources\Player\PlayerResource;
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
     * @return array<PlayerLiteResource>
     */
    public function top()
    {
        return PlayerLiteResource::collection(Player::getTopPlayers());
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
            'query' => 'required|string|max:255',
        ]);

        $query = $request->input('query');

        $players = Player::where('name', 'LIKE', '%' . $query . '%')->get();

        return PlayerLiteResource::collection($players);
    }


    /**
     * Get a Player resource.
     */
    public function show(Player $player)
    {
        // this never will happens, because is handled in app/Exceptions/Handler.php on render()
        // but is to show on api docs
        if ($player == null) {
            /**
             * A Player resource.
             *
             * @status 404
             * @body array{ error: "Player not found"}
             */
            return response()->json([
                'error' => 'Player not found'
            ], Response::HTTP_NOT_FOUND);
        }

        return new PlayerResource($player);
    }
}
