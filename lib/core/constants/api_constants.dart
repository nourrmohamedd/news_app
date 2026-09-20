abstract final class ApiConstants {
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String topHeadlinesPath = '/top-headlines';
  static const String sourcesPath = '/top-headlines/sources';
  static const String everythingPath = '/everything';

  static const String apiKeyHeader = 'X-Api-Key';

  static const String apiKey = String.fromEnvironment('NEWS_API_KEY');

  static const int pageSize = 10;

  static const String qCategory = 'category';
  static const String qSources = 'sources';
  static const String qPage = 'page';
  static const String qPageSize = 'pageSize';
  static const String qQuery = 'q';
  static const String qSortBy = 'sortBy';

  static const String sortByPublishedAt = 'publishedAt';
}
