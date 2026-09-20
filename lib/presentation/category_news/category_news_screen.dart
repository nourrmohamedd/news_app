import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/category_model.dart';
import '../../data/repositories/news_repository.dart';
import '../../l10n/app_localizations.dart';
import '../../logic/news/news_cubit.dart';
import '../../logic/news/news_state.dart';
import '../home/widgets/app_drawer.dart';
import '../home/widgets/category_name.dart';
import 'widgets/article_preview_dialog.dart';
import 'widgets/message_view.dart';
import 'widgets/news_list.dart';
import 'widgets/source_tabs.dart';
import '../search/search_screen.dart';

class CategoryNewsScreen extends StatelessWidget {
  const CategoryNewsScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => NewsCubit(c.read<NewsRepository>())..init(category.id),
      child: _CategoryNewsView(category: category),
    );
  }
}

class _CategoryNewsView extends StatelessWidget {
  const _CategoryNewsView({required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName(context, category.id)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchScreen())),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          final cubit = context.read<NewsCubit>();

          Widget content() => switch (state.status) {
            NewsStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            NewsStatus.failure => MessageView(
              message: l10n.somethingWentWrong,
              onRetry: cubit.retry,
            ),
            NewsStatus.success =>
              state.articles.isEmpty
                  ? MessageView(message: l10n.noArticles)
                  : NewsList(
                      key: ValueKey(state.selectedSourceId),
                      articles: state.articles,
                      isLoadingMore: state.isLoadingMore,
                      onLoadMore: cubit.loadMore,
                      onArticleTap: (a) => showArticlePreview(context, a),
                    ),
          };

          if (state.sources.isEmpty) return content();

          return Column(
            children: [
              SourceTabs(
                sources: state.sources,
                selectedId: state.selectedSourceId,
                onSelected: cubit.selectSource,
              ),
              Expanded(child: content()),
            ],
          );
        },
      ),
    );
  }
}
