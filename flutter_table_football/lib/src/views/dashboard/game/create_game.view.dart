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
import 'package:go_router/go_router.dart';

class CreateGameView extends StatefulWidget {
  static const routeName = "game/create";

  const CreateGameView({super.key});

  @override
  State<CreateGameView> createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> with FormHelper {
  int _currentStep = 0;
  final int steps = 3;
  final List<TeamLite> selectedTeams = List.empty(growable: true);
  final List<TeamLite> teams = List.empty(growable: true);

  @override
  void initState() {
    // load from API all the available players
    // TODO Implement Lazy load to avoid load all the teams at once
    TeamsRepository.getAll().then((value) => setState(() {
          teams.addAll(value);
          toIdle();
        }));
    super.initState();
  }

  void onStepContinue() {
    if (_currentStep < steps) {
      setState(() {
        switch (_currentStep) {
          case 0:
            // if still waiting for the list of teams from repository
            if (isLoading) return;
            // avoid to go next without at least a player
            if (selectedTeams.isEmpty) return;
            if (selectedTeams.length == 2) _currentStep += 1;
            break;
        }

        _currentStep += 1;
      });
    }
  }

  void onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void createAndNavigateToTeamView() {
    toSubmitting();
    // create the team and navigate to the game page
    Map<String, dynamic> data = {
      "teams": selectedTeams,
    };
    GamesRepository.create(data).then((newTeam) {
      // navigates to the Team view after create the team
      debugPrint("Game Created successfully");
      context.showErrorSnackBar("Game Created successfully!", type: MessageTypes.success);
      context.replace(GameView.routePath, extra: newTeam);
    }).catchError((error) {
      toIdle();
      context.showErrorSnackBar("Ups! Please try later.", type: MessageTypes.error);
      debugPrint("An error occurred while creating the game : $error");
    });
  }

  // handle the click of next buttons
  void nextStep(ControlsDetails details) {
    if (details.currentStep == steps - 1) {
      createAndNavigateToTeamView();
      return;
    }
    details.onStepContinue?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Game"),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: onStepContinue,
        onStepTapped: (value) => setState(() => value < _currentStep ? _currentStep = value : null),
        onStepCancel: onStepCancel,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Padding(
            padding: const EdgeInsets.only(top: kSpacing),
            child: Row(
              children: <Widget>[_renderNextStepButton(details), _renderBackStepButton(details)],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('1º Team'),
            content: renderStepSelectTeam(0),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('2º Team'),
                "optional".note(context),
              ],
            ),
            content: renderStepSelectTeam(1),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Resume'),
            content: renderResume(),
            isActive: _currentStep >= 3,
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
          ),
        ],
      ),
    );
  }

  ElevatedButton _renderNextStepButton(ControlsDetails details) {
    return isSubmitting
        ? const ElevatedButton(
            onPressed: null,
            child: CircularProgressIndicator.adaptive(),
          )
        : ElevatedButton(
            onPressed: () => nextStep(details),
            child: Text(details.currentStep == steps - 1 ? 'Create' : 'Next'),
          );
  }

  Widget _renderBackStepButton(ControlsDetails details) {
    // Only show Back button if not on the first step
    if (_currentStep > 0 && !isSubmitting) {
      return TextButton(
        onPressed: details.onStepCancel,
        child: const Text('Back'),
      );
    }

    return const SizedBox.shrink();
  }

  Widget renderResume() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Game Teams:".h4(context),
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
        children: [Text("Loading Teams list"), SizedBox(width: kSpacing), CircularProgressIndicator.adaptive()],
      );
    }
    return TextButton(
      onPressed: () => openBottomSheetToSelectPlayers(p),
      child: Row(
        children: [
          // if the current player do not exists yet
          if (selectedTeams.length <= p) ...[
            const Icon(Icons.person_add),
            const SizedBox(width: kSpacing),
            Expanded(child: Text("Add the $pº Team to the game")),
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
  void openBottomSheetToSelectPlayers(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BottomDraggableScrollableContainer<TeamLite>(
          title: "Title",
          elements: teams,
          renderItem: (element) {
            final team = element;
            return TeamSearchableListItem(team: team);
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
