import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/searchable.model.dart';
import 'package:flutter_table_football/src/widgets/searchable_list.widget.dart';

class BottomDraggableScrollableContainer<T extends Searchable> extends StatelessWidget {
  final String title;
  final List<T> elements;
  final Widget Function(T element) renderItem;

  const BottomDraggableScrollableContainer({super.key, required this.title, required this.elements, required this.renderItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => context.pop,
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.95,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(
                // allow overflow
                clipBehavior: Clip.none,
                children: [
                  // Container that makes the layout
                  Container(
                    margin: const EdgeInsets.only(top: kSpacingLarge),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: context.colorScheme.background,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(kBorderRadiusLarge),
                        topLeft: Radius.circular(kBorderRadiusLarge),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Top widget (Title and close button)
                        _Top(title: title),
                        // Body
                        Expanded(
                          child: SearchableList<T>(
                            scrollController: scrollController,
                            elements: elements,
                            renderItem: renderItem,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Floating button
                  Positioned(
                    top: 0,
                    left: kSpacingMedium,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: context.colorScheme.primary,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Widget that build the header options of the modal
class _Top extends StatelessWidget {
  const _Top({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(child: SizedBox.shrink()),
        Expanded(child: Center(child: title.title)),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              onPressed: () => context.pop,
              child: "Done".toText,
            ),
          ),
        ),
      ],
    );
  }
}
