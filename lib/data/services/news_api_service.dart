import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';
import '../models/article_model.dart';
import '../models/source_model.dart';

class ApiException implements Exception {
  const ApiException(this.message, {this.code});
  final String message;
  final String? code;

  @override
  String toString() => 'ApiException($code): $message';
}

class NewsApiService {
  NewsApiService({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;

  Future<List<SourceModel>> fetchSources({required String category}) async {
    final json = await _get(ApiConstants.sourcesPath, {
      ApiConstants.qCategory: category,
    });
    final list = json['sources'] as List<dynamic>? ?? [];
    return list
        .map((e) => SourceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ArticlesPage> fetchArticles({
    required String sourceId,
    required int page,
  }) async {
    final all = await _fetchBySource(
      ApiConstants.everythingPath,
      sourceId,
      page,
    );
    if (all.totalResults > 0 || page > 1) return all;
    return _fetchBySource(ApiConstants.topHeadlinesPath, sourceId, page);
  }

  Future<ArticlesPage> _fetchBySource(
    String path,
    String sourceId,
    int page,
  ) async {
    final json = await _get(path, {
      ApiConstants.qSources: sourceId,
      ApiConstants.qPage: '$page',
      ApiConstants.qPageSize: '${ApiConstants.pageSize}',
    });
    return _parseArticles(json);
  }

  Future<ArticlesPage> searchArticles({
    required String query,
    required int page,
  }) async {
    final json = await _get(ApiConstants.everythingPath, {
      ApiConstants.qQuery: query,
      ApiConstants.qSortBy: ApiConstants.sortByPublishedAt,
      ApiConstants.qPage: '$page',
      ApiConstants.qPageSize: '${ApiConstants.pageSize}',
    });
    return _parseArticles(json);
  }

  ArticlesPage _parseArticles(Map<String, dynamic> json) {
    final list = json['articles'] as List<dynamic>? ?? [];
    return ArticlesPage(
      articles: list
          .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['totalResults'] as num?)?.toInt() ?? 0,
    );
  }

  Future<Map<String, dynamic>> _get(
    String path,
    Map<String, String> query,
  ) async {
    if (ApiConstants.apiKey.isEmpty) {
      throw const ApiException(
        'NEWS_API_KEY is missing. Run with --dart-define=NEWS_API_KEY=your_key',
      );
    }
    final uri = Uri.parse('${ApiConstants.baseUrl}$path')
        .replace(queryParameters: query);
    final response = await _client
        .get(uri, headers: {ApiConstants.apiKeyHeader: ApiConstants.apiKey})
        .timeout(const Duration(seconds: 20));

    final body =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    if (response.statusCode != 200 || body['status'] != 'ok') {
      throw ApiException(
        body['message'] as String? ?? 'Unknown error',
        code: body['code'] as String?,
      );
    }
    return body;
  }
}
