<?php

namespace App\Http\Controllers;

use App\Http\Requests\Player\StorePlayerRequest;
use App\Http\Resources\Player\PlayerResource;
use App\Models\Player;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class PlayersController extends Controller
{
    /**
     * check if a nickname is available for new player.
     * We use the StorePlayerRequest to validate if it's empty or already in use.
     */
    public function checkNickname(StorePlayerRequest $request)
    {
        return response()->json([
            'message' => 'Success',
        ], Response::HTTP_OK);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StorePlayerRequest $request)
    {
        $player = Player::create($request->validated());
        return response()->json([
            'data' => new PlayerResource($player),
        ], Response::HTTP_CREATED);
    }

    /**
     * Get the top players of all time.
     */
    public function top()
    {
        $list = Player::getTopPlayers();
        return response()->json([
            'data' => PlayerResource::collection($list),
        ], Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource.
     */
    public function show(Player $player)
    {
        return response()->json([
            'data' => new PlayerResource($player),
        ], Response::HTTP_OK);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Player $player)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Player $player)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Player $player)
    {
        //
    }
}
