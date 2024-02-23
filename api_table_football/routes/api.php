<?php

use Illuminate\Http\Request;
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

// List all teams
Route::get('/teams', [TeamController::class, 'index']);

// Get a specific team by ID
Route::get('/teams/{id}', [TeamController::class, 'show']);
