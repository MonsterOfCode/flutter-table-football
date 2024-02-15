import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/widgets/bottom_draggable_container.widget.dart';
import 'package:flutter_table_football/src/widgets/list_items/player_searchable_list_item.dart';
import 'package:go_router/go_router.dart';

List<Player> staticPlayers = [
  const Player(name: "Player 1", points: 150),
  const Player(name: "Player 2", points: 15),
  const Player(name: "Player 3", points: 10),
  const Player(name: "Player 4", points: 9),
  const Player(name: "Player 5", points: 6),
  const Player(name: "Player 6", points: 5),
];

class CreateTeamView extends StatefulWidget {
  static const routeName = "team/create";

  const CreateTeamView({super.key});

  @override
  State<CreateTeamView> createState() => _CreateTeamViewState();
}

class _CreateTeamViewState extends State<CreateTeamView> {
  int _currentStep = 0;
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final List<Player> players = List.empty(growable: true);
  final int steps = 4;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
          elements: staticPlayers,
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
        if (players.length > index) {
          players[index] = staticPlayers[Random().nextInt(staticPlayers.length)];
        } else {
          players.add(staticPlayers[Random().nextInt(staticPlayers.length)]);
        }
      });
    });
  }

  void onStepContinue() {
    if (_currentStep < steps) {
      setState(() {
        switch (_currentStep) {
          case 0:
            // avoid to go next without a name for the team
            if (_nameController.text.isEmpty) {
              _nameFocusNode.requestFocus();
              return;
            }
          case 1:
            // avoid to go next without at least a player
            if (players.isEmpty) return;
            if (players.length == 2) _currentStep += 1;
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
              children: <Widget>[
                ElevatedButton(
                  onPressed: details.currentStep == steps - 1 ? context.pop : details.onStepContinue,
                  child: Text(details.currentStep == steps - 1 ? 'Create' : 'Next'),
                ),
                // Only show Back button if not on the first step
                if (_currentStep > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Team Name'),
            content: TextFormField(
              controller: _nameController,
              focusNode: _nameFocusNode,
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

  Widget renderResume() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Team name:".h4(context),
            Text(_nameController.text),
          ],
        ),
        const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Team members:".h4(context),
            Column(
              children: players.map((item) {
                return Text(item.name);
              }).toList(),
            )
          ],
        ),
      ],
    );
  }

  Widget renderStepSelectPlayer(int p) {
    return TextButton(
      onPressed: () => openBottomSheetToSelectPlayers(p),
      child: Row(
        children: [
          // if the current player do not exists yet
          if (players.length <= p) ...[
            const Icon(Icons.person_add),
            const SizedBox(width: kSpacing),
            const Expanded(child: Text("Add a player to the team")),
          ],
          // if the player is already selected
          if (players.length > p) Expanded(child: players[p].name.toText),
        ],
      ),
    );
  }
}
