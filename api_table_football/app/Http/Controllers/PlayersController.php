<?php

namespace App\Http\Controllers;

use App\Http\Requests\Player\StorePlayerRequest;
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
        return response()->json($player, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Player $player)
    {
        //
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
