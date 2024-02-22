import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/container.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';

class CreateGameScoreSection extends StatelessWidget {
  final TeamLite teamA;
  final TeamLite teamB;
  final int scoreTeamA;
  final int scoreTeamB;
  final void Function(int scoreTeamA, int scoreTeamB) onScoreChange;
  const CreateGameScoreSection({super.key, required this.teamA, required this.teamB, required this.scoreTeamA, required this.scoreTeamB, required this.onScoreChange});

  void _showCupertinoPicker(BuildContext context, bool isFirstNumber) {
    final int currentValue = isFirstNumber ? scoreTeamA : scoreTeamB;
    final int otherValue = isFirstNumber ? scoreTeamB : scoreTeamA;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: CupertinoPicker(
            magnification: 1.22,
            backgroundColor: CupertinoColors.white,
            itemExtent: 32.0,
            onSelectedItemChanged: (int value) {
              if (isFirstNumber) {
                onScoreChange(value, scoreTeamB);
              } else {
                onScoreChange(scoreTeamA, value);
              }
            },
            scrollController: FixedExtentScrollController(initialItem: currentValue),
            children: List<Widget>.generate(10 - otherValue, (int index) {
              return Center(child: Text('$index'));
            }),
          ),
        ).toBottomSheet(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CupertinoButton(
          child: Row(
            children: [
              teamA.name.title,
              const SizedBox(width: kSpacingLarge),
              "$scoreTeamA".title,
            ],
          ),
          onPressed: () => _showCupertinoPicker(context, true),
        ),
        ":".bigTitle(context).color(context.colorScheme.onBackground),
        CupertinoButton(
          child: Row(
            children: [
              "$scoreTeamB".title,
              const SizedBox(width: kSpacingLarge),
              teamB.name.title,
            ],
          ),
          onPressed: () => _showCupertinoPicker(context, false),
        ),
      ],
    );
  }
}
