import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';

/// Our DataTable theme
class DataTablePrimaryTheme extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  const DataTablePrimaryTheme({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) => context.colorScheme.primary),
      headingTextStyle: context.textTheme.labelLarge!.copyWith(color: Colors.white),
      columns: columns,
      rows: rows,
    );
  }
}
