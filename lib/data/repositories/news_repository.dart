import '../models/article_model.dart';
import '../models/source_model.dart';
import '../services/news_api_service.dart';

class NewsRepository {
  NewsRepository(this._service);
  final NewsApiService _service;

  Future<List<SourceModel>> getSources(String category) async {
    final sources = await _service.fetchSources(category: category);
    return sources.where((s) => s.id.isNotEmpty).toList();
  }

  Future<ArticlesPage> getArticles({
    required String sourceId,
    required int page,
  }) async {
    final result = await _service.fetchArticles(sourceId: sourceId, page: page);
    return _withoutRemoved(result);
  }

  Future<ArticlesPage> searchArticles({
    required String query,
    required int page,
  }) async {
    final result = await _service.searchArticles(query: query, page: page);
    return _withoutRemoved(result);
  }

  ArticlesPage _withoutRemoved(ArticlesPage page) => ArticlesPage(
    articles: page.articles.where((a) => !a.isRemoved).toList(),
    totalResults: page.totalResults,
  );
}
