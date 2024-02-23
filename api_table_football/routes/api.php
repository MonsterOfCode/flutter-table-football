<?php

use App\Http\Controllers\PlayersController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Routes only as authenticated user
Route::prefix('players')->name('players.')->group(function () {
    // List top player
    Route::get('/', [PlayersController::class, 'top']);

    // Get a specific player by nickname
    Route::get('/{player}', [PlayersController::class, 'show']);
});
