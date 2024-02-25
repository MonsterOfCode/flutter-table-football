import 'dart:async';
import 'package:flutter/material.dart';

///Simple Future list
///
class FutureList<T> extends StatelessWidget {
  final Widget Function(T element) renderItem;
  final Future<List<T>> Function() fetchItems;
  const FutureList({super.key, required this.renderItem, required this.fetchItems});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: fetchItems(),
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
              return renderItem(snapshot.data![index]);
            },
          );
        }
        return const Center(child: Text('No results to show'));
      },
    );
  }
}
