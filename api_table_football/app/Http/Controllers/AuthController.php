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

class AuthController extends Controller
{

    /**
     * Authenticate/Identify Player
     */
    public function authenticate(Player $player)
    {
        return new PlayerResource($player);
    }
}
