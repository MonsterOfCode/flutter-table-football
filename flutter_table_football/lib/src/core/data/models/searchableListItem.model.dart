import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/models/searchable.model.dart';

/// Stats Model
///
/// A model that implements the standard attributes to be displayed in a ListTile
/// * [Widget] leadingWhenSelected
/// * [String] title
/// * [String] trailing
abstract class SearchableListItem implements Searchable {
  const SearchableListItem();

  /// Default leading widget when the item will be selected
  Widget get leadingWhenSelected => const Icon(Icons.check);

  /// title to be displayed on the ListTile
  String get title;

  /// trailing to be displayed on the ListTile
  String get trailing;
}
