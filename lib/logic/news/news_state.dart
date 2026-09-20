import 'package:equatable/equatable.dart';

import '../../data/models/article_model.dart';
import '../../data/models/source_model.dart';

enum NewsStatus { loading, success, failure }

class NewsState extends Equatable {
  const NewsState({
    this.status = NewsStatus.loading,
    this.sources = const [],
    this.selectedSourceId,
    this.articles = const [],
    this.page = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final NewsStatus status;
  final List<SourceModel> sources;
  final String? selectedSourceId;
  final List<ArticleModel> articles;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  NewsState copyWith({
    NewsStatus? status,
    List<SourceModel>? sources,
    String? selectedSourceId,
    List<ArticleModel>? articles,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
  }) => NewsState(
    status: status ?? this.status,
    sources: sources ?? this.sources,
    selectedSourceId: selectedSourceId ?? this.selectedSourceId,
    articles: articles ?? this.articles,
    page: page ?? this.page,
    hasMore: hasMore ?? this.hasMore,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
  );

  @override
  List<Object?> get props => [
    status,
    sources,
    selectedSourceId,
    articles,
    page,
    hasMore,
    isLoadingMore,
  ];
}
