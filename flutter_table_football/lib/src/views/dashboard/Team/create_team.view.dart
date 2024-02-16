import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/mixins/form_validations.mixin.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/repositories/players.repository.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/team/team.view.dart';
import 'package:flutter_table_football/src/widgets/bottom_draggable_container.dart';
import 'package:flutter_table_football/src/widgets/list_items/player_searchable_list_item.dart';
import 'package:go_router/go_router.dart';

class CreateTeamView extends StatefulWidget {
  static const routeName = "team/create";

  const CreateTeamView({super.key});

  @override
  State<CreateTeamView> createState() => _CreateTeamViewState();
}

class _CreateTeamViewState extends State<CreateTeamView> with FormHelper {
  int _currentStep = 0;
  final int steps = 4;
  final List<Player> selectedPlayers = List.empty(growable: true);
  final List<Player> players = List.empty(growable: true);

  @override
  void initState() {
    // load from API all the available players
    // TODO Implement Lazy load to avoid load all the players at once
    PlayersRepository.getAll().then((value) => setState(() {
          players.addAll(value);
          toIdle();
        }));
    super.initState();
  }

  void onStepContinue() {
    if (_currentStep < steps) {
      setState(() {
        switch (_currentStep) {
          case 0:
            // avoid to go next without a name for the team
            if (!validateForm()) {
              activeAutoValidator();
              requestFocusTo("name");
              return;
            }
          case 1:
            // if still waiting for the list of players from repository
            if (isLoading) return;
            // avoid to go next without at least a player
            if (selectedPlayers.isEmpty) return;
            if (selectedPlayers.length == 2) _currentStep += 1;
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
      "name": getControllerValue("name"),
      "players": selectedPlayers,
    };
    TeamsRepository.create(data).then((newTeam) {
      // navigates to the Team view after create the team
      debugPrint("Team Created successfully");
      context.showErrorSnackBar("Team Created successfully!", type: MessageTypes.success);
      context.replace(TeamView.routePath, extra: newTeam);
    }).catchError((error) {
      toIdle();
      context.showErrorSnackBar("Ups! Please try later.", type: MessageTypes.error);
      debugPrint("An error occurred while creating the team : $error");
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
        title: const Text("Create Team"),
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
            title: const Text('Team Name'),
            content: Form(
              autovalidateMode: autovalidateMode,
              key: formKey,
              child: TextFormField(
                validator: (value) => notEmpty(value, msg: "The Team name is required"),
                controller: getController("name"),
                focusNode: getNodeFocus("name"),
                keyboardType: TextInputType.text,
              ),
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('1º Player'),
            content: renderStepSelectPlayer(0),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('2º Player'),
                "optional".note(context),
              ],
            ),
            content: renderStepSelectPlayer(1),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Team name:".h4(context),
            Text(getControllerValue("name")),
          ],
        ),
        const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Team members:".h4(context),
            Column(
              children: selectedPlayers.map((item) {
                return Text(item.name);
              }).toList(),
            )
          ],
        ),
      ],
    );
  }

  Widget renderStepSelectPlayer(int p) {
    if (isLoading) {
      return const Row(
        children: [Text("Loading players list"), SizedBox(width: kSpacing), CircularProgressIndicator.adaptive()],
      );
    }
    return TextButton(
      onPressed: () => openBottomSheetToSelectPlayers(p),
      child: Row(
        children: [
          // if the current player do not exists yet
          if (selectedPlayers.length <= p) ...[
            const Icon(Icons.person_add),
            const SizedBox(width: kSpacing),
            const Expanded(child: Text("Add a player to the team")),
          ],
          // if the player is already selected
          if (selectedPlayers.length > p) Expanded(child: selectedPlayers[p].name.toText),
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
        return BottomDraggableScrollableContainer<Player>(
          title: "Title",
          elements: players,
          renderItem: (element) {
            final player = element;
            return PlayerSearchableListItem(player: player);
          },
        );
      },
    ).then((value) {
      setState(() {
        //TODO: refactor to be dynamic
        // is editing
        if (selectedPlayers.length > index) {
          selectedPlayers[index] = players[Random().nextInt(players.length)];
        } else {
          selectedPlayers.add(players[Random().nextInt(players.length)]);
        }
      });
    });
  }
}
