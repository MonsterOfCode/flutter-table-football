<?php

namespace App\Http\Requests\Game;

use Illuminate\Foundation\Http\FormRequest;

class StoreGameRequest extends FormRequest
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
            'teamAId' => 'required|exists:teams,id',
            'teamBId' => 'required|exists:teams,id|different:team_a_id',
            'teamAScore' => 'required|integer|min:0',
            'teamBScore' => 'required|integer|min:0',
            'done' => 'required|boolean',
            'game_date' => 'required|date',
        ];
    }
}
