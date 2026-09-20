import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/api_constants.dart';
import '../../data/repositories/news_repository.dart';
import 'search_state.dart';

import 'dart:async';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._repository) : super(const SearchState());

  final NewsRepository _repository;
  int _requestId = 0;
  Timer? _debounce;

  static const int _minLength = 1;

  void onQueryChanged(String value) {
    _debounce?.cancel();
    final query = value.trim();
    if (query.length < _minLength) {
      clear();
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 200), () => search(query));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  Future<void> search(String rawQuery) async {
    _debounce?.cancel();
    final query = rawQuery.trim();
    if (query.isEmpty) {
      clear();
      return;
    }
    if (query == state.query &&
        (state.status == SearchStatus.loading ||
            state.status == SearchStatus.success)) {
      return;
    }
    final id = ++_requestId;
    emit(SearchState(status: SearchStatus.loading, query: query));
    try {
      final result = await _repository.searchArticles(query: query, page: 1);
      if (id != _requestId) return;
      emit(
        SearchState(
          status: SearchStatus.success,
          query: query,
          articles: result.articles,
          page: 1,
          hasMore: ApiConstants.pageSize < result.totalResults,
        ),
      );
    } catch (e) {
      debugPrint('SearchCubit.search error: $e');
      if (id == _requestId) {
        emit(SearchState(status: SearchStatus.failure, query: query));
      }
    }
  }

  Future<void> loadMore() async {
    if (state.status != SearchStatus.success ||
        state.isLoadingMore ||
        !state.hasMore) {
      return;
    }
    final id = _requestId;
    final nextPage = state.page + 1;
    emit(state.copyWith(isLoadingMore: true));
    try {
      final result = await _repository.searchArticles(
        query: state.query,
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
      debugPrint('SearchCubit.loadMore error: $e');
      if (id == _requestId) {
        emit(state.copyWith(isLoadingMore: false, hasMore: false));
      }
    }
  }

  void clear() {
    _debounce?.cancel();
    _requestId++;
    emit(const SearchState());
  }

  Future<void> retry() => search(state.query);
}
