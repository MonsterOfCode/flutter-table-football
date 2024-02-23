<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Game extends Model
{
    use HasFactory;

    protected $fillable = ['team_a_id', 'team_b_id', 'team_a_score', 'team_b_score', 'done', 'game_date'];


    /**
     * Get the home team that played the game.
     */
    public function teamHome()
    {
        return $this->belongsTo(Team::class, 'team_a_id');
    }

    /**
     * Get the away team that played the game.
     */
    public function teamAway()
    {
        return $this->belongsTo(Team::class, 'team_b_id');
    }
}
