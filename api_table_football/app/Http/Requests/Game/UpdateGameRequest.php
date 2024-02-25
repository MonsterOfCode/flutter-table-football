<?php

namespace App\Http\Requests\Game;

use Illuminate\Foundation\Http\FormRequest;

class UpdateGameRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            /**
             * to avoid any conflicts with other async action
             * we require the score of each team and the action:
             *  -1 to remove, 1 to add and 0 no action
             * @var int
             * @example 4
             */
            'team_a_score' => 'sometimes|required|integer|min:0',
            /**
             * Same situation of  `teamAScore` but for Team B.
             * @var int
             * @example 4
             */
            'team_b_score' => 'sometimes|required|integer|min:0',
            /**
             * Is a increment of Team A score
             * @var int
             * @example 1
             */
            'team_a_action' => 'sometimes|required|integer|min:-1|max:1',
            /**
             * No action on Team B
             * @var int
             * @example 0
             */
            'team_b_action' => 'sometimes|required|integer|min:-1|max:1',
            /**
             * If the game is done or not
             * @var boolean
             * @example false
             */
            'done' => 'sometimes|required|boolean',
        ];
    }
}
