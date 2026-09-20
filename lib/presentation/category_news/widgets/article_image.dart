import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_palette.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({super.key, required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final placeholderColor = context.palette.border.withValues(alpha: 0.12);
    Widget placeholder(Widget child) => ColoredBox(
      color: placeholderColor,
      child: Center(child: child),
    );

    final imageUrl = url;
    if (imageUrl == null || imageUrl.isEmpty) {
      return placeholder(const Icon(Icons.image_not_supported_outlined));
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      placeholder: (_, _) => placeholder(
        const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (_, _, _) =>
          placeholder(const Icon(Icons.broken_image_outlined)),
    );
  }
}
