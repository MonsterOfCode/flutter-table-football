import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';

class CreateGameResumeSection extends StatelessWidget {
  final List<TeamLite> selectedTeams;
  final bool alreadyFinishedGame;
  final void Function(bool?)? onToggleAlreadyFinishedGame;
  final int? scoreTeamA;
  final int? scoreTeamB;
  const CreateGameResumeSection({super.key, required this.selectedTeams, required this.alreadyFinishedGame, this.onToggleAlreadyFinishedGame, this.scoreTeamA, this.scoreTeamB});

  @override
  Widget build(BuildContext context) {
    return selectedTeams.length != 2
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Game teams:".h4(context),
                  Row(
                    children: [
                      Column(
                        children: [
                          selectedTeams[0].name.toText,
                          if (alreadyFinishedGame && scoreTeamA != null) "$scoreTeamA".toText,
                        ],
                      ),
                      const SizedBox(width: kSpacing),
                      "vs".bigNote(context),
                      const SizedBox(width: kSpacing),
                      Column(
                        children: [
                          selectedTeams[1].name.toText,
                          if (alreadyFinishedGame && scoreTeamB != null) "$scoreTeamB".toText,
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Is a already finished game?'),
                  Checkbox(
                    value: alreadyFinishedGame,
                    onChanged: onToggleAlreadyFinishedGame,
                  ),
                ],
              ),
            ],
          );
  }
}
