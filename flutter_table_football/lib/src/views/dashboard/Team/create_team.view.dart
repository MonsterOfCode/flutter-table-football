import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/mixins/form_validations.mixin.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/repositories/players.repository.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/team/team.view.dart';
import 'package:flutter_table_football/src/widgets/bottom_draggable_container.dart';
import 'package:flutter_table_football/src/widgets/list_items/default_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/stepped.dart';
import 'package:go_router/go_router.dart';

class CreateTeamView extends StatefulWidget {
  static const routeName = "team/create";

  const CreateTeamView({super.key});

  @override
  State<CreateTeamView> createState() => _CreateTeamViewState();
}

class _CreateTeamViewState extends State<CreateTeamView> with FormHelper {
  final List<PlayerLite> _selectedPlayers = List.empty(growable: true);
  // used to automatic move to next step if the user selects both players at once
  int _currentStep = 0;

  void _createAndNavigateToTeamView() {
    toSubmitting();
    // create the team and navigate to the game page
    Map<String, dynamic> data = {
      "name": getControllerValue("name"),
      "players": _selectedPlayers,
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

  int _executeOnStep0() {
    // avoid to go next without a name for the team
    if (!validateForm()) {
      activeAutoValidator();
      requestFocusTo("name");
      return 0;
    }
    return 1;
  }

  int _executeOnStep1() {
    // avoid to go next without at least a player
    if (_selectedPlayers.isEmpty) return 0;
    if (_selectedPlayers.length == 2) return 2;
    return 1;
  }

  /// Function that will handle the selected players
  ///
  /// Returns true if the path runs as expected
  ///
  /// Returns false if the widget must not assume any further action
  bool _addPlayer(PlayerLite player) {
    if (_selectedPlayers.contains(player)) {
      setState(() {
        _selectedPlayers.remove(player);
        // if the user removes all selected players must go the 2º step
        if (_currentStep == 2 && _selectedPlayers.isEmpty) {
          _currentStep = 1;
        }
      });

      return true;
    }

    // limit select only 2 elements
    if (_selectedPlayers.length == 2) return false;

    setState(() {
      _selectedPlayers.add(player);
      if (_selectedPlayers.length == 1) {
        // if the user selects the 2º player at same time of the 1º player
        if (_currentStep != 2) {
          _currentStep = 2;
        }
      } else {
        // if the user is selecting the last player we move to last step and close the
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
      title: "Create Team".title,
      currentStepFromParent: _currentStep,
      onStepChanges: (step) => setState(() => _currentStep = step),
      done: _createAndNavigateToTeamView,
      executeOnStepContinue: {0: _executeOnStep0, 1: _executeOnStep1},
      steps: [
        StepItem(
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
        ),
        StepItem(title: const Text('1º Player'), content: renderStepSelectPlayer(0)),
        StepItem(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('2º Player'),
                "optional".note(context),
              ],
            ),
            content: renderStepSelectPlayer(1)),
        StepItem(title: const Text('Resume'), content: renderResume()),
      ],
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
              children: _selectedPlayers.map((item) {
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
          if (_selectedPlayers.length <= p) ...[
            const Icon(Icons.person_add),
            const SizedBox(width: kSpacing),
            const Expanded(child: Text("Add a player to the team")),
          ],
          // if the player is already selected
          if (_selectedPlayers.length > p) Expanded(child: _selectedPlayers[p].name.toText),
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
        return BottomDraggableScrollableContainer<PlayerLite>(
          title: "Players",
          fetchItems: PlayersRepository.getByQuery,
          renderItem: (element) {
            return DefaultSearchableListItem<PlayerLite>(
              model: element,
              onSelect: _addPlayer,
              isSelected: _selectedPlayers.contains(element),
            );
          },
        );
      },
    );
  }
}
