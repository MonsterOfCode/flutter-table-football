import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/models/stats.model.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/widgets/data_table_primary_theme.dart';

const columns = [
  DataColumn(label: Text('Team/Player Name')),
  DataColumn(label: Text('Games Played')),
  DataColumn(label: Text('Wins')),
  DataColumn(label: Text('Losses')),
  DataColumn(label: Text('Ratio')),
  DataColumn(label: Text('GF (Goals For)')),
  DataColumn(label: Text('GA (Goals Against)')),
  DataColumn(label: Text('GD (Goals Difference)')),
];

class StatsTable<T extends Stats> extends StatelessWidget {
  final Future<List<T>> future;
  final Widget? title;

  const StatsTable({super.key, required this.future, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title ?? const SizedBox.shrink(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              FutureBuilder<List<T>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        DataTablePrimaryTheme(
                          columns: columns,
                          rows: [
                            DataRow(
                              cells: List.generate(
                                8,
                                (index) => const DataCell(
                                  Center(child: CircularProgressIndicator.adaptive()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  if (snapshot.hasData) {
                    // Build and display table rows once data is available
                    final rows = snapshot.data!.asMap().entries.map<DataRow>((entry) {
                      int index = entry.key; // Get the current index
                      var item = entry.value; // Get the current item

                      return DataRow(
                        color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                          if (index % 2 != 0) {
                            return context.colorScheme.primary.withOpacity(0.4);
                          }
                          return null;
                        }),
                        cells: [
                          DataCell(Text(item.name)),
                          DataCell(Text(item.matches.toString())),
                          DataCell(Text(item.wins.toString())),
                          DataCell(Text(item.losses.toString())),
                          DataCell(Text(item.ratio.toString())),
                          DataCell(Text(item.goalsFor.toString())),
                          DataCell(Text(item.goalsAgainst.toString())),
                          DataCell(Text(item.goalsDiference.toString())),
                        ],
                      );
                    }).toList();
                    return DataTablePrimaryTheme(columns: columns, rows: rows);
                  }
                  return Center(child: "No results to show".toText);
                },
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
