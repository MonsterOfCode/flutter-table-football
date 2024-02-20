import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/models/searchableListItem.model.dart';

///  Widget to show the Lite models items in the searchable list
///
/// This widget is stateful to better render optimizations
///
/// [onSelect] must return true if the widget must updates the [isSelected] state
///
/// [isSelected] initial value for the selection status of this item
class DefaultSearchableListItem<T extends SearchableListItem> extends StatefulWidget {
  final bool Function(T element)? onSelect;
  final bool isSelected;
  final T model;

  const DefaultSearchableListItem({
    super.key,
    required this.model,
    this.onSelect,
    this.isSelected = false,
  });

  @override
  State<DefaultSearchableListItem<T>> createState() => _DefaultSearchableListItemState<T>();
}

class _DefaultSearchableListItemState<T extends SearchableListItem> extends State<DefaultSearchableListItem<T>> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  void onTap() {
    if (widget.onSelect?.call(widget.model) ?? false) {
      setState(() {
        _isSelected = !_isSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: _isSelected ? widget.model.leadingWhenSelected : null,
      title: Text(widget.model.title),
      trailing: Text(widget.model.trailing),
      selected: _isSelected,
    );
  }
}
