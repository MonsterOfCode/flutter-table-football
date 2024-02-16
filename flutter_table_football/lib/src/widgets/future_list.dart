import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';

class FutureListWidget<T> extends StatelessWidget {
  final Future<List<T>>? future;
  final Widget? Function(T element) renderItem;

  const FutureListWidget({super.key, this.future, required this.renderItem});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          return Center(child: "${snapshot.error}".toText);
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return renderItem(snapshot.data![index]);
            },
          );
        } else {
          return Center(child: "No results to show".toText);
        }
      },
    );
  }
}
