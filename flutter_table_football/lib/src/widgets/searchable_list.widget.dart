import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/searchable.model.dart';

class SearchableList<T extends Searchable> extends StatefulWidget {
  final ScrollController? scrollController;
  final Widget Function(T element) renderItem;
  final List<T> elements;
  final void Function(T element)? onSelect;

  const SearchableList({
    super.key,
    this.scrollController,
    required this.elements,
    this.onSelect,
    required this.renderItem,
  });

  @override
  State<SearchableList<T>> createState() => _SearchableListState<T>();
}

class _SearchableListState<T extends Searchable> extends State<SearchableList<T>> {
  TextEditingController searchInputController = TextEditingController();
  FocusNode searchInputFocusNode = FocusNode();
  List<T> filteredPlayers = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    filteredPlayers = widget.elements;
  }

  void cleanSearch() {
    setState(() {
      searchInputController.clear();
      searchInputController.text = "";
      searchInputFocusNode.unfocus();
      filteredPlayers = widget.elements;
    });
  }

  void search(String value) {
    if (value.isEmpty) return cleanSearch();

    setState(() {
      filteredPlayers = widget.elements.where((element) => element.searchable.contains(value.trim().toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: TextField(
            controller: searchInputController,
            focusNode: searchInputFocusNode,
            onChanged: search,
            decoration: InputDecoration(
              labelText: "Search",
              suffix: searchInputController.text.trim().isNotEmpty ? GestureDetector(onTap: cleanSearch, child: const Icon(Icons.close)) : const Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: filteredPlayers.isEmpty
              ? Center(child: "No results to show".toText)
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredPlayers.length,
                  itemBuilder: (context, index) {
                    return widget.renderItem(filteredPlayers[index]);
                  },
                  controller: widget.scrollController,
                ),
        ),
      ],
    );
  }
}
