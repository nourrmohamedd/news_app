import 'package:flutter/material.dart';

import '../../../core/theme/app_palette.dart';
import '../../../data/models/article_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../article_web_view/article_web_view_screen.dart';
import 'article_image.dart';

Future<void> showArticlePreview(BuildContext context, ArticleModel article) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => ArticlePreviewDialog(article: article),
  );
}

class ArticlePreviewDialog extends StatelessWidget {
  const ArticlePreviewDialog({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l10n = AppLocalizations.of(context);

    return Dialog(
      alignment: Alignment.bottomCenter,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: p.cardBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ArticleImage(url: article.imageUrl),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  article.previewText,
                  style: TextStyle(
                    color: p.cardText,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: p.arrowBackground,
                  foregroundColor: p.arrowIcon,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final url = article.url;
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  if (url != null && url.isNotEmpty) {
                    navigator.push(
                      MaterialPageRoute(
                        builder: (_) => ArticleWebViewScreen(
                          url: url,
                          title: article.sourceName,
                        ),
                      ),
                    );
                  }
                },
                child: Text(l10n.viewFullArticle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
