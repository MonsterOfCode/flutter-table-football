<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

class Game extends Model
{
    use HasFactory;

    protected $fillable = ['team_a_id', 'team_b_id', 'team_a_score', 'team_b_score', 'done', 'game_date'];

    /**
     * Get the top teams globally based on points.
     *
     * @param int $limit Number of top teams to return.
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public static function getLastGames($limit = 20)
    {
        return self::orderBy('game_date', 'DESC')->take($limit)->get();
    }

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

    /// [action] 1: for , -1 : Against
    public function incrementTeamAndPlayersGoals($team, $action)
    {

        switch ($action) {
            case 1:
                $team->increment('goals_for');
                break;
            default:
                $team->increment('goals_against');
                break;
        }

        // Increment points for all players of the team
        foreach ($team->players as $player) {
            switch ($action) {
                case 1:
                    $player->increment('goals_for');
                    break;
                default:
                    $player->increment('goals_against');
                    break;
            }
        }
    }

    // Method to call when the game ends
    public function concludeGame()
    {
        $teamAWins = $this->team_a_score > $this->team_b_score;
        $teamBWins = $this->team_b_score > $this->team_a_score;
        $tie = $this->team_a_score === $this->team_b_score;

        Log::info("message: Game concluded", [$teamAWins, $teamBWins, $tie, $this]);
        if ($teamAWins) {
            $this->incrementTeamAndPlayersPoints($this->teamHome, 1);
            $this->incrementTeamAndPlayersPoints($this->teamAway, -1);
        } elseif ($teamBWins) {
            $this->incrementTeamAndPlayersPoints($this->teamHome, -1);
            $this->incrementTeamAndPlayersPoints($this->teamAway, 1);
        } elseif ($tie) {
            $this->incrementTeamAndPlayersPoints($this->teamHome, 0);
            $this->incrementTeamAndPlayersPoints($this->teamAway, 0);
        }
    }

    /// [action] 1: win , -1 : lose, 0 : tie
    protected function incrementTeamAndPlayersPoints($team, $action)
    {

        switch ($action) {
            case 1:
                $team->increment('wins');
                // Increment team points
                $team->increment('points', 3);
                break;
            case 0:
                // Increment team points
                $team->increment('points', 1);
                break;
            default:
                $team->increment('losses');
                break;
        }

        // Increment points for all players of the team
        foreach ($team->players as $player) {
            switch ($action) {
                case 1:
                    $player->increment('wins');
                    // Increment player points
                    $player->increment('points', 3);
                    break;
                case 0:
                    // Increment player points
                    $player->increment('points', 1);
                    break;
                default:
                    $player->increment('losses');
                    break;
            }
        }
    }
}
