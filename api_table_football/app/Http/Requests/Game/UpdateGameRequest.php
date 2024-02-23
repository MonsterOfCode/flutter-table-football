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
            'id' => 'required|exists:games,id',
            // to avoid any conflicts with other async action
            // we require the score of each team and the action, -1 => remove, 0, 1 => add
            'teamAScore' => 'required|integer|min:0',
            'teamBScore' => 'required|integer|min:0',
            'teamAScoreAction' => 'sometimes|required|integer|min:-1|max:1',
            'teamBScoreAction' => 'sometimes|required|integer|min:-1|max:1',
            'done' => 'sometimes|required|boolean',
        ];
    }
}
