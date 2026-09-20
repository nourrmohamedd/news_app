import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/api_constants.dart';
import '../../data/repositories/news_repository.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._repository) : super(const NewsState());

  final NewsRepository _repository;
  String _category = '';

  int _requestId = 0;

  Future<void> init(String category) async {
    _category = category;
    final id = ++_requestId;
    emit(const NewsState(status: NewsStatus.loading));
    try {
      final sources = await _repository.getSources(category);
      if (id != _requestId) return;
      if (sources.isEmpty) {
        emit(const NewsState(status: NewsStatus.success));
        return;
      }
      emit(NewsState(status: NewsStatus.loading, sources: sources));
      await selectSource(sources.first.id);
    } catch (e) {
      debugPrint('NewsCubit.init error: $e');
      if (id == _requestId) emit(const NewsState(status: NewsStatus.failure));
    }
  }

  Future<void> selectSource(String sourceId) async {
    final id = ++_requestId;
    emit(
      state.copyWith(
        selectedSourceId: sourceId,
        status: NewsStatus.loading,
        articles: const [],
        page: 0,
        hasMore: false,
        isLoadingMore: false,
      ),
    );
    try {
      final result = await _repository.getArticles(sourceId: sourceId, page: 1);
      if (id != _requestId) return;
      //debugPrint('source=$sourceId totalResults=${result.totalResults}');
      emit(
        state.copyWith(
          status: NewsStatus.success,
          articles: result.articles,
          page: 1,
          hasMore: ApiConstants.pageSize < result.totalResults,
        ),
      );
    } catch (e) {
      debugPrint('NewsCubit.selectSource error: $e');
      if (id == _requestId) emit(state.copyWith(status: NewsStatus.failure));
    }
  }

  Future<void> loadMore() async {
    final sourceId = state.selectedSourceId;
    if (sourceId == null ||
        state.status != NewsStatus.success ||
        state.isLoadingMore ||
        !state.hasMore) {
      return;
    }
    final id = _requestId;
    final nextPage = state.page + 1;
    emit(state.copyWith(isLoadingMore: true));
    try {
      final result = await _repository.getArticles(
        sourceId: sourceId,
        page: nextPage,
      );
      if (id != _requestId) return;
      emit(
        state.copyWith(
          articles: [...state.articles, ...result.articles],
          page: nextPage,
          hasMore: nextPage * ApiConstants.pageSize < result.totalResults,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      debugPrint('NewsCubit.loadMore error: $e');
      if (id == _requestId) {
        emit(state.copyWith(isLoadingMore: false, hasMore: false));
      }
    }
  }

  Future<void> retry() {
    final sourceId = state.selectedSourceId;
    if (state.sources.isEmpty || sourceId == null) return init(_category);
    return selectSource(sourceId);
  }
}
