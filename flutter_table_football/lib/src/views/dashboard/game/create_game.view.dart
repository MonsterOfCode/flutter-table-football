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
import 'package:flutter_table_football/src/widgets/bottom_draggable_container.dart';
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
  final List<TeamLite> teams = List.empty(growable: true);

  @override
  void initState() {
    // load from API all the available players
    // TODO Implement Lazy load to avoid load all the players at once
    TeamsRepository.getAll().then((value) => setState(() {
          teams.addAll(value);
          toIdle();
        }));
    super.initState();
  }

  void createAndNavigateToTeamView() {
    toSubmitting();
    // create the team and navigate to the game page
    Map<String, dynamic> data = {
      "players": selectedTeams,
    };
    GamesRepository.create(data).then((newGame) {
      // navigates to the Team view after create the team
      debugPrint("Game Created successfully");
      context.showErrorSnackBar("Game Created successfully!", type: MessageTypes.success);
      context.replace(GameView.routeName, extra: newGame);
    }).catchError((error) {
      toIdle();
      context.showErrorSnackBar("Ups! Please try later.", type: MessageTypes.error);
      debugPrint("An error occurred while creating the game : $error");
    });
  }

  int executeOnStep0() {
    // if still waiting for the list of players from repository
    if (isLoading) return 0;
    // avoid to go next without at least a player
    if (selectedTeams.isEmpty) return 0;
    if (selectedTeams.length == 2) return 2;
    return 1;
  }

  int executeOnStep1() {
    if (selectedTeams.length != 2) return 0;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Stepped(
      title: "Create Game".title,
      done: createAndNavigateToTeamView,
      executeOnStepContinue: {0: executeOnStep0, 1: executeOnStep1},
      steps: [
        (
          const Text('1º Team'),
          renderStepSelectTeam(0),
        ),
        (
          const Text('2º Team'),
          renderStepSelectTeam(1),
        ),
        (
          const Text('Resume'),
          renderResume(),
        )
      ],
    );
  }

  Widget renderResume() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Game teams:".h4(context),
            Column(
              children: selectedTeams.map((item) {
                return Text(item.name);
              }).toList(),
            )
          ],
        ),
      ],
    );
  }

  Widget renderStepSelectTeam(int p) {
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
          title: "Title",
          elements: teams,
          renderItem: (element) {
            return TeamSearchableListItem(team: element);
          },
        );
      },
    ).then((value) {
      setState(() {
        //TODO: refactor to be dynamic
        // is editing
        if (selectedTeams.length > index) {
          selectedTeams[index] = teams[Random().nextInt(teams.length)];
        } else {
          selectedTeams.add(teams[Random().nextInt(teams.length)]);
        }
      });
    });
  }
}
