import 'package:flutter/material.dart';

import '../../../data/models/source_model.dart';

class SourceTabs extends StatelessWidget {
  const SourceTabs({
    super.key,
    required this.sources,
    required this.selectedId,
    required this.onSelected,
  });

  final List<SourceModel> sources;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: sources.length,
        separatorBuilder: (_, _) => const SizedBox(width: 18),
        itemBuilder: (context, i) {
          final source = sources[i];
          final selected = source.id == selectedId;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onSelected(source.id),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selected ? color : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                source.name,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
