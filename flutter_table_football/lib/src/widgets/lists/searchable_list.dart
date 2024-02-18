import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/data/models/searchable.model.dart';

class SearchableList<T extends Searchable> extends StatefulWidget {
  final ScrollController? scrollController;
  final Widget Function(T element) renderItem;
  final Future<List<T>> Function({String query})? fetchItems;
  final void Function(T element)? onSelect;

  const SearchableList({
    super.key,
    this.scrollController,
    this.onSelect,
    required this.renderItem,
    this.fetchItems,
  });

  @override
  State<SearchableList<T>> createState() => _SearchableListState<T>();
}

class _SearchableListState<T extends Searchable> extends State<SearchableList<T>> {
  TextEditingController searchInputController = TextEditingController();
  FocusNode searchInputFocusNode = FocusNode();
  Future<List<T>>? _futureItems;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _executeQuery();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _executeQuery({String query = ''}) {
    setState(() {
      _futureItems = widget.fetchItems?.call(query: query);
    });
  }

  void _onSearchChanged({String query = ''}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _executeQuery(query: query);
    });
  }

  void cleanSearch() {
    setState(() {
      searchInputController.clear();
      searchInputController.text = "";
      searchInputFocusNode.unfocus();
      _executeQuery();
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
            onChanged: (value) => _onSearchChanged(query: value),
            decoration: InputDecoration(
              labelText: "Search",
              suffix: searchInputController.text.trim().isNotEmpty ? GestureDetector(onTap: cleanSearch, child: const Icon(Icons.close)) : const Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: _futureItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }
              if (snapshot.hasError) {
                debugPrint("Error getting list of $T on $runtimeType widget: ${snapshot.error}");
                return const Center(child: Text('Ups! Please Try later'));
              }
              int nItems = snapshot.data?.length ?? 0;
              if (nItems > 0) {
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return widget.renderItem(snapshot.data![index]);
                  },
                );
              }
              return const Center(child: Text('No results to show'));
            },
          ),
        ),
      ],
    );
  }
}
