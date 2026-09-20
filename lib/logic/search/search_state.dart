import 'package:equatable/equatable.dart';

import '../../data/models/article_model.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.query = '',
    this.articles = const [],
    this.page = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final SearchStatus status;
  final String query;
  final List<ArticleModel> articles;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<ArticleModel>? articles,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
  }) => SearchState(
    status: status ?? this.status,
    query: query ?? this.query,
    articles: articles ?? this.articles,
    page: page ?? this.page,
    hasMore: hasMore ?? this.hasMore,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
  );

  @override
  List<Object?> get props => [
    status,
    query,
    articles,
    page,
    hasMore,
    isLoadingMore,
  ];
}
