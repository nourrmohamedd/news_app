import 'package:equatable/equatable.dart';

class ArticleModel extends Equatable {
  const ArticleModel({
    required this.title,
    required this.sourceName,
    this.author,
    this.description,
    this.content,
    this.url,
    this.imageUrl,
    this.publishedAt,
  });

  final String title;
  final String sourceName;
  final String? author;
  final String? description;
  final String? content;
  final String? url;
  final String? imageUrl;
  final DateTime? publishedAt;

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final source = json['source'] as Map<String, dynamic>?;
    return ArticleModel(
      title: (json['title'] as String?)?.trim() ?? '',
      sourceName: source?['name'] as String? ?? '',
      author: json['author'] as String?,
      description: json['description'] as String?,
      content: json['content'] as String?,
      url: json['url'] as String?,

      imageUrl: (json['urlToImage'] as String?)?.replaceFirst(
        'http://',
        'https://',
      ),
      publishedAt: DateTime.tryParse(json['publishedAt'] as String? ?? ''),
    );
  }

  bool get isRemoved => title.isEmpty || title == '[Removed]';

  String get displayAuthor {
    final a = author?.trim();
    return (a != null && a.isNotEmpty) ? a : sourceName;
  }

  String get previewText {
    for (final t in [content, description, title]) {
      if (t != null && t.trim().isNotEmpty) {
        return t.replaceAll(RegExp(r'\s+'), ' ').trim();
      }
    }
    return '';
  }

  @override
  List<Object?> get props => [
    title,
    sourceName,
    author,
    description,
    content,
    url,
    imageUrl,
    publishedAt,
  ];
}

class ArticlesPage {
  const ArticlesPage({required this.articles, required this.totalResults});
  final List<ArticleModel> articles;
  final int totalResults;
}
