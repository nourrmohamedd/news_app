import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_palette.dart';
import '../../data/repositories/news_repository.dart';
import '../../l10n/app_localizations.dart';
import '../../logic/search/search_cubit.dart';
import '../../logic/search/search_state.dart';
import '../category_news/widgets/article_preview_dialog.dart';
import '../category_news/widgets/message_view.dart';
import '../category_news/widgets/news_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => SearchCubit(c.read<NewsRepository>()),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = context.palette;
    final cubit = context.read<SearchCubit>();

    OutlineInputBorder border(double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: p.border, width: width),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: TextField(
                controller: _textController,
                autofocus: true,
                textInputAction: TextInputAction.search,
                onChanged: cubit.onQueryChanged,
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                  cubit.search(value);
                },
                decoration: InputDecoration(
                  hintText: l10n.search,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _textController.clear();
                      cubit.clear();
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  enabledBorder: border(1),
                  focusedBorder: border(1.5),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) => switch (state.status) {
                  SearchStatus.initial => MessageView(
                    message: l10n.searchPrompt,
                  ),
                  SearchStatus.loading => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  SearchStatus.failure => MessageView(
                    message: l10n.somethingWentWrong,
                    onRetry: cubit.retry,
                  ),
                  SearchStatus.success =>
                    state.articles.isEmpty
                        ? MessageView(message: l10n.noArticles)
                        : NewsList(
                            key: ValueKey(state.query),
                            articles: state.articles,
                            isLoadingMore: state.isLoadingMore,
                            onLoadMore: cubit.loadMore,
                            onArticleTap: (a) => showArticlePreview(context, a),
                          ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
