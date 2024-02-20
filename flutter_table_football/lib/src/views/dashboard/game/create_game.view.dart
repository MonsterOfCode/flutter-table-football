import 'dart:math';

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
import 'package:flutter_table_football/src/widgets/list_items/team_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/stepped.dart';
import 'package:go_router/go_router.dart';

class CreateGameView extends StatefulWidget {
  static const routeName = "game/create";

  const CreateGameView({super.key});

  @override
  State<CreateGameView> createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> with FormHelper {
  final List<TeamLite> selectedTeams = List.empty(growable: true);
  bool alreadyFinishedGame = false;
  int scoreTeamA = 0;
  int scoreTeamB = 0;
  // used to navigate to the 3 step automatically if the user selects that is a already finished game
  int _currentStep = 0;

  // Function that is called at the end of all steps to finally create the Game
  void createAndNavigateToTeamView() {
    toSubmitting();
    // create the team and navigate to the game page
    Map<String, dynamic> data = {
      "players": selectedTeams,
      "scoreTeamA": scoreTeamA,
      "scoreTeamB": scoreTeamB,
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
  int executeOnStep0() {
    // if still waiting for the list of players from repository
    if (isLoading) return 0;
    // avoid to go next without at least a player
    if (selectedTeams.isEmpty) return 0;
    return 1;
  }

  // function that executes when the current step is 1 and is going to the next
  int executeOnStep1() {
    if (selectedTeams.length != 2) return 0;
    return 2;
  }

  // function used by the CreateGameScoreSection widget to notify the values that the user selects
  void updateGameScore(int scoreTeamA, int scoreTeamB) {
    setState(() {
      this.scoreTeamA = scoreTeamA;
      this.scoreTeamB = scoreTeamB;
    });
  }

  // When the user click to toggle the checkbox if the game is already finished or not
  void onToggleAlreadyFinishedGame(bool? value) {
    setState(() {
      alreadyFinishedGame = value!;
      if (alreadyFinishedGame) {
        _currentStep = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stepped(
      title: "Create Game".title,
      currentStepFromParent: _currentStep,
      onStepChanges: (step) => setState(() => _currentStep = step),
      // we lock the direct click to the 3 step
      lockDirectNavigationTo: alreadyFinishedGame ? null : const [2],
      done: createAndNavigateToTeamView,
      executeOnStepContinue: {0: executeOnStep0, 1: executeOnStep1},
      steps: [
        StepItem(title: const Text('1º Team'), content: renderSelectTeamSection(0)),
        StepItem(title: const Text('2º Team'), content: renderSelectTeamSection(1)),
        StepItem(
            title: const Text('Game Result'),
            content: alreadyFinishedGame
                ? CreateGameScoreSection(
                    teamA: selectedTeams[0],
                    teamB: selectedTeams[1],
                    scoreTeamA: scoreTeamA,
                    scoreTeamB: scoreTeamB,
                    onScoreChange: updateGameScore,
                  )
                : const SizedBox.shrink()),
        StepItem(
            title: const Text('Resume'),
            content: CreateGameResumeSection(
              selectedTeams: selectedTeams,
              alreadyFinishedGame: alreadyFinishedGame,
              onToggleAlreadyFinishedGame: onToggleAlreadyFinishedGame,
              scoreTeamA: scoreTeamA,
              scoreTeamB: scoreTeamB,
            )),
      ],
    );
  }

  Widget renderSelectTeamSection(int p) {
    if (isLoading) {
      return const Row(
        children: [Text("Loading teams list"), SizedBox(width: kSpacing), CircularProgressIndicator.adaptive()],
      );
    }
    return TextButton(
      onPressed: () => openBottomSheetToSelectTeams(p),
      child: Row(
        children: [
          // if the current player do not exists yet
          if (selectedTeams.length <= p) ...[
            const Icon(Icons.person_add),
            const SizedBox(width: kSpacing),
            Expanded(child: Text("Add the ${p + 1}º team to the game")),
          ],
          // if the player is already selected
          if (selectedTeams.length > p) Expanded(child: selectedTeams[p].name.toText),
        ],
      ),
    );
  }

  /// This function will open the bottom sheet to select the player
  ///
  /// [index] is the player to be selected
  ///
  /// with the [index] we can also know if is to edit or to add a new player
  void openBottomSheetToSelectTeams(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BottomDraggableScrollableContainer<TeamLite>(
          title: "Teams",
          fetchItems: TeamsRepository.getByQuery,
          renderItem: (element) {
            return TeamSearchableListItem(team: element);
          },
        );
      },
    ).then((value) {
      TeamsRepository.getByQuery().then(
        (teams) {
          setState(() {
            //TODO: refactor to be dynamic
            // is editing
            if (selectedTeams.length > index) {
              selectedTeams[index] = teams[Random().nextInt(teams.length)];
            } else {
              selectedTeams.add(teams[Random().nextInt(teams.length)]);
            }
          });
        },
      );
    });
  }
}
