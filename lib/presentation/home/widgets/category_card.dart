import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_palette.dart';
import '../../../data/models/category_model.dart';
import '../../../l10n/app_localizations.dart';
import 'category_name.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.index,
    required this.onViewAll,
  });

  final CategoryModel category;
  final int index;
  final VoidCallback onViewAll;

  bool get _imageAtStart => index.isEven;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    final image = Positioned.fill(
      child: Image.asset(
        AppAssets.category(category.imageKey, isDark: context.isDark),
        fit: BoxFit.fill,
      ),
    );

    final content = Align(
      alignment: _imageAtStart ? Alignment.centerRight : Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: const Offset(0, -15),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    categoryName(context, category.id),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(color: p.cardText, fontSize: 34),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _ViewAllPill(arrowAtEnd: _imageAtStart, onTap: onViewAll),
            ],
          ),
        ),
      ),
    );

    return Container(
      height: 190,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Stack(children: [image, content]),
    );
  }
}

class _ViewAllPill extends StatelessWidget {
  const _ViewAllPill({required this.arrowAtEnd, required this.onTap});
  final bool arrowAtEnd;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    final shift = (arrowAtEnd ? 1 : -1) * 15.0;
    final label = Text(
      AppLocalizations.of(context).viewAll,
      style: TextStyle(color: p.pillText, fontSize: 19),
    );
    final arrow = Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: p.arrowBackground,
        shape: BoxShape.circle,
      ),
      child: Icon(
        arrowAtEnd
            ? Icons.arrow_forward_ios_rounded
            : Icons.arrow_back_ios_new_rounded,
        size: 20,
        color: p.arrowIcon,
      ),
    );

    return Transform.translate(
      offset: Offset(shift, 25),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          decoration: BoxDecoration(
            color: p.pillBackground,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: arrowAtEnd
                ? [
                    const SizedBox(width: 20),
                    label,
                    const SizedBox(width: 10),
                    arrow,
                  ]
                : [
                    arrow,
                    const SizedBox(width: 10),
                    label,
                    const SizedBox(width: 20),
                  ],
          ),
        ),
      ),
    );
  }
}
