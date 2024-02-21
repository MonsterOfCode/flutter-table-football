import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/mixins/form_validations.mixin.dart';
import 'package:flutter_table_football/src/data/repositories/players.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/player/player.view.dart';
import 'package:flutter_table_football/src/widgets/stepped.dart';
import 'package:go_router/go_router.dart';

class CreatePlayerView extends StatefulWidget {
  static const routeName = "player/create";

  const CreatePlayerView({super.key});

  @override
  State<CreatePlayerView> createState() => _CreatePlayerViewState();
}

class _CreatePlayerViewState extends State<CreatePlayerView> with FormHelper {
  // used to navigate after validate the nickname async
  int _currentStep = 0;

  @override
  void initState() {
    toIdle();
    super.initState();
  }

  void createAndNavigateToTeamView() {
    toSubmitting();
    // create the team and navigate to the game page
    Map<String, dynamic> data = {
      "name": getControllerValue("name").trim().toLowerCase(),
    };
    PlayersRepository.create(data).then((newPlayer) {
      // navigates to the Team view after create the team
      debugPrint("Player Created successfully");
      context.showErrorSnackBar("Player Created successfully!", type: MessageTypes.success);
      context.replace(PlayerView.routePath, extra: newPlayer);
    }).catchError((error) {
      toIdle();
      context.showErrorSnackBar("Ups! Please try later.", type: MessageTypes.error);
      debugPrint("An error occurred while creating the player : $error");
    });
  }

  int executeOnStep0() {
    // before make a new validation clean the current errors
    cleanErrorsFromApi();

    // avoid to go next without a name for the team
    if (!validateForm()) {
      activeAutoValidator();
      requestFocusTo("name");
      return 0;
    }
    toSubmitting();
    PlayersRepository.validateNickname(getControllerValue('name').trim()).then((value) {
      toIdle();
      //TODO change to response type
      if (value is Map<String, dynamic>) {
        addErrorMessage(value["errors"]);
        return;
      }
      setState(() {
        _currentStep = 1;
      });
    });
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stepped(
      title: "Create Player".title,
      currentStepFromParent: _currentStep,
      onStepChanges: (step) => setState(() => _currentStep = step),
      done: createAndNavigateToTeamView,
      executeOnStepContinue: {0: executeOnStep0},
      steps: [
        StepItem(
          title: const Text('Player Nickname'),
          content: Column(
            children: [
              Form(
                autovalidateMode: autovalidateMode,
                key: formKey,
                child: isSubmitting
                    ? Row(
                        children: ["Validating the nickname".toText, const CircularProgressIndicator.adaptive()],
                      )
                    : TextFormField(
                        decoration: InputDecoration(
                          errorText: getErrorFor('name'),
                        ),
                        validator: (value) => validators(
                          [
                            () => notEmpty(value, msg: "The nickname is required"),
                            () => withErrorMessages('name'),
                          ],
                        ),
                        controller: getController("name"),
                        focusNode: getNodeFocus("name"),
                        keyboardType: TextInputType.text,
                      ),
              ),
            ],
          ),
        ),
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
            "Player nickname:".h4(context),
            Text(getControllerValue("name").trim().toLowerCase()),
          ],
        ),
      ],
    );
  }
}
