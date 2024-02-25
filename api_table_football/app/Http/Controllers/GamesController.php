<?php

namespace App\Http\Controllers;

use App\Http\Requests\Game\StoreGameRequest;
use App\Http\Requests\Game\UpdateGameRequest;
use App\Http\Resources\Game\GameResource;
use App\Http\Resources\Game\GamesCollection;
use App\Models\Game;
use Carbon\Carbon;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class GamesController extends Controller
{
 
    /**
     * List of last 20 games.
     *
     * @return array<Game>
     */
    public function lastGames()
    {
        /**
         * @body array<GameResource>
         */
        return new GamesCollection(Game::getLastGames());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreGameRequest $request)
    {

        // Start a transaction
        DB::beginTransaction();

        try {

            $validated = $request->validated();

            $datetime = Carbon::now();
            $validated['game_date'] = $datetime;

            $game = Game::create($validated);

            // Commit the transaction
            DB::commit();
            /**
             * A Team resource.
             *
             * @status 201
             * @body GameResource
             */
            return response()->json(new GameResource($game), Response::HTTP_CREATED);
        } catch (\Exception $e) {
            // Rollback the transaction
            DB::rollback();
            throw $e;
        }
    }

    /**
     * Get a Game resource.
     */
    public function show(Game $game)
    {
        return new GameResource($game);
    }

    /**
     * Update a game.
     *
     * we allow multiple actions at same time
     */
    public function update(UpdateGameRequest $request, $id)
    {

        // Start a transaction
        DB::beginTransaction();

        try {

            $game = Game::findOrFail($id);
            
            if($game->done){
               return new GameResource($game); 
            }
            
            $scoreSum = $game->team_a_score + $game->team_b_score;
            
            //if there is an action to team A/Home
            if ($request->team_a_action != 0) {
                // the received score most be equals to the current from DB
                if ($game->team_a_score == $request->team_a_score) {
                    if ($request->team_a_action == 1) {
                        $game->increment('team_a_score');
                        $scoreSum++;
                    } else {
                        $game->decrement('team_a_score');
                        $scoreSum--;
                    }
                }
            }

            //if there is an action to team B/Away
            if ($request->team_b_action != 0) {
                // the received score most be equals to the current from DB
                if ($game->team_b_score == $request->team_b_score) {
                    if ($request->team_b_action == 1) {
                        $game->increment('team_b_score');
                        $scoreSum++;
                    } else {
                        $game->decrement('team_b_score');
                        $scoreSum--;
                    }
                }
            }
            

            if ($request->has('done')) {
                $game->done = $request->done;
            }else{
                if($scoreSum == 9){
                   $game->done = true;
                }
            }

            $game->save();

            // Commit the transaction
            DB::commit();

            return new GameResource($game);
        } catch (\Exception $e) {
            // Rollback the transaction
            DB::rollback();
            throw $e;
        }
    }
}
