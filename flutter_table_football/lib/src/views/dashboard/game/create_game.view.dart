import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/mixins/form_validations.mixin.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/repositories/games.repository.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/game/game.view.dart';
import 'package:flutter_table_football/src/widgets/game/resume_section_create_game.dart';
import 'package:flutter_table_football/src/widgets/bottom_draggable_container.dart';
import 'package:flutter_table_football/src/widgets/game/score_section_create_game.dart';
import 'package:flutter_table_football/src/widgets/list_items/default_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/stepped.dart';
import 'package:go_router/go_router.dart';

class CreateGameView extends StatefulWidget {
  static const routeName = "game/create";

  const CreateGameView({super.key});

  @override
  State<CreateGameView> createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> with FormHelper {
  final List<TeamLite> _selectedTeams = List.empty(growable: true);
  bool _alreadyFinishedGame = false;
  int _scoreTeamA = 0;
  int _scoreTeamB = 0;
  // used to navigate to the 3 step automatically if the user selects that is a already finished game
  int _currentStep = 0;

  // Function that is called at the end of all steps to finally create the Game
  void _createAndNavigateToTeamView() {
    toSubmitting();
    // create the team and navigate to the game page
    Map<String, dynamic> data = {
      "players": _selectedTeams,
      "scoreTeamA": _scoreTeamA,
      "scoreTeamB": _scoreTeamB,
    };
    GamesRepository.create(data).then((newGame) {
      // navigates to the Team view after create the team
      debugPrint("Game Created successfully");
      context.showErrorSnackBar("Game Created successfully!", type: MessageTypes.success);
      context.replace(GameView.routePath, extra: newGame);
    }).catchError((error) {
      toIdle();
      context.showErrorSnackBar("Ups! Please try later.", type: MessageTypes.error);
      debugPrint("An error occurred while creating the game : $error");
    });
  }

  // function that executes when the current step is 0 and is going to the next
  int _executeOnStep0() {
    // if still waiting for the list of players from repository
    if (isLoading) return 0;
    // avoid to go next without at least a player
    if (_selectedTeams.isEmpty) return 0;
    return 1;
  }

  // function that executes when the current step is 1 and is going to the next
  int _executeOnStep1() {
    if (_selectedTeams.length != 2) return 0;
    return 2;
  }

  // function used by the CreateGameScoreSection widget to notify the values that the user selects
  void _updateGameScore(int scoreTeamA, int scoreTeamB) {
    setState(() {
      _scoreTeamA = scoreTeamA;
      _scoreTeamB = scoreTeamB;
    });
  }

  // When the user click to toggle the checkbox if the game is already finished or not
  void _onToggleAlreadyFinishedGame(bool? value) {
    setState(() {
      _alreadyFinishedGame = value!;
      if (_alreadyFinishedGame) {
        _currentStep = 2;
      }
    });
  }

  /// Function that will handle the selected teams
  ///
  /// Returns true if the path runs as expected
  ///
  /// Returns false if the widget must not assume any further action
  bool _addTeam(TeamLite team) {
    if (_selectedTeams.contains(team)) {
      setState(() {
        _selectedTeams.remove(team);
        // if the user removes all selected players must go the 2º step
        if (_currentStep == 1 && _selectedTeams.isEmpty) {
          _currentStep = 0;
        }
      });

      return true;
    }

    // limit select only 2 elements
    if (_selectedTeams.length == 2) return false;

    setState(() {
      _selectedTeams.add(team);

      // if the user selects the 1 team we move automatically to the next step
      if (_selectedTeams.length == 1) {
        if (_currentStep != 1) {
          _currentStep = 1;
        }
      } else {
        // if the user is selecting the last team we move to last step and close the
        // selectable list
        if (_currentStep != 3) {
          _currentStep = 3;
          Navigator.of(context).pop();
        }
      }
    });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Stepped(
      title: "Create Game".title,
      currentStepFromParent: _currentStep,
      onStepChanges: (step) => setState(() => _currentStep = step),
      // we lock the direct click to the 3 step
      lockDirectNavigationTo: _alreadyFinishedGame ? null : const [2],
      done: _createAndNavigateToTeamView,
      executeOnStepContinue: {0: _executeOnStep0, 1: _executeOnStep1},
      steps: [
        StepItem(title: const Text('1º Team'), content: renderSelectTeamSection(0)),
        StepItem(title: const Text('2º Team'), content: renderSelectTeamSection(1)),
        StepItem(
            title: const Text('Game Result'),
            content: _alreadyFinishedGame
                ? CreateGameScoreSection(
                    teamA: _selectedTeams[0],
                    teamB: _selectedTeams[1],
                    scoreTeamA: _scoreTeamA,
                    scoreTeamB: _scoreTeamB,
                    onScoreChange: _updateGameScore,
                  )
                : const SizedBox.shrink()),
        StepItem(
            title: const Text('Resume'),
            content: CreateGameResumeSection(
              selectedTeams: _selectedTeams,
              alreadyFinishedGame: _alreadyFinishedGame,
              onToggleAlreadyFinishedGame: _onToggleAlreadyFinishedGame,
              scoreTeamA: _scoreTeamA,
              scoreTeamB: _scoreTeamB,
            )),
      ],
    );
  }

  Widget renderSelectTeamSection(int p) {
    return TextButton(
      onPressed: () => openBottomSheetToSelectTeams(),
      child: Row(
        children: [
          // if the current player do not exists yet
          if (_selectedTeams.length <= p) ...[
            const Icon(Icons.gamepad),
            const SizedBox(width: kSpacing),
            Expanded(child: Text("Add the ${p + 1}º team to the game")),
          ],
          // if the player is already selected
          if (_selectedTeams.length > p) Expanded(child: _selectedTeams[p].name.toText),
        ],
      ),
    );
  }

  /// This function will open the bottom sheet to select the team
  void openBottomSheetToSelectTeams() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BottomDraggableScrollableContainer<TeamLite>(
          title: "Teams",
          fetchItems: TeamsRepository.getByQuery,
          renderItem: (element) {
            return DefaultSearchableListItem<TeamLite>(
              model: element,
              onSelect: _addTeam,
              isSelected: _selectedTeams.contains(element),
            );
          },
        );
      },
    );
  }
}
