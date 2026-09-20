import 'package:flutter/material.dart';

import '../../../data/models/article_model.dart';
import 'news_card.dart';

class NewsList extends StatefulWidget {
  const NewsList({
    super.key,
    required this.articles,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onArticleTap,
  });

  final List<ArticleModel> articles;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final ValueChanged<ArticleModel> onArticleTap;

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final extra = widget.isLoadingMore ? 1 : 0;
    return ListView.separated(
      controller: _controller,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: widget.articles.length + extra,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, i) {
        if (i >= widget.articles.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final article = widget.articles[i];
        return NewsCard(
          article: article,
          onTap: () => widget.onArticleTap(article),
        );
      },
    );
  }
}
