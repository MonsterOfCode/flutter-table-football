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
            /**
             * @example 12
             */
            'team_a_id' => 'required|exists:teams,id',
            /**
             * @example 7
             */
            'team_b_id' => 'required|exists:teams,id|different:team_a_id',
            /**
             * @example 5
             */
            'team_a_score' => 'required|integer|min:0',
            /**
             * @example 4
             */
            'team_b_score' => 'required|integer|min:0',
            'done' => 'required|boolean',
            /**
             * Game DataTime.
             * @var string
             * @example 23-02-2024 15:30
             */
            'game_date' => 'required|date_format:d-m-Y H:i',
        ];
    }
}
