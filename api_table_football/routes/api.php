<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\GamesController;
use App\Http\Controllers\PlayersController;
use App\Http\Controllers\TeamsController;
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

Route::prefix('auth')->name('auth.')->group(function () {
    // List top players
    Route::get('/{player}', [AuthController::class, 'authenticate']);
});


Route::prefix('players')->name('players.')->group(function () {
    // List top players
    Route::get('/top', [PlayersController::class, 'top']);

    // List top teams of player
    Route::get('/top/{player}/teams', [PlayersController::class, 'topTeams']);

    // Create a player
    Route::post('/new', [PlayersController::class, 'store']);

    // Search for a player
    Route::get('/search', [PlayersController::class, 'search']);

    // Check if nickname is available
    Route::get('/nickname', [PlayersController::class, 'checkNickname']);

    // Get a specific player by nickname
    Route::get('/{player}', [PlayersController::class, 'show']);
});

Route::prefix('teams')->name('teams.')->group(function () {
    // List top teams
    Route::get('/top', [TeamsController::class, 'top']);

    // Create a Team
    Route::post('/new', [TeamsController::class, 'store']);

    // Search for a Team
    Route::get('/search', [TeamsController::class, 'search']);

    // Get a specific team by id
    Route::get('/{team}', [TeamsController::class, 'show']);
});

Route::prefix('games')->name('games.')->group(function () {
    // List top games
    Route::get('/', [GamesController::class, 'last']);

    // Create a game
    Route::post('/new', [GamesController::class, 'store']);

    // Update a game
    Route::put('/{id}', [GamesController::class, 'update']);


    // // Search for a game
    // Route::get('/search', [TeamsController::class, 'search']);

    // Get a specific game by id
    Route::get('/{game}', [GamesController::class, 'show']);
});
