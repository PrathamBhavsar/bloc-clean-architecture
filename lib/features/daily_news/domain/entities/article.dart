import 'package:equatable/equatable.dart';

/// Entities are business objects in an app
/// Represents the core article data structure.

class ArticleEntity extends Equatable {
  final int? id;
  final String? sourceId;
  final String? sourceName;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleEntity({
    this.id,
    this.sourceId,
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  /// Defines which properties should be compared for equality.
  @override
  List<Object?> get props {
    return [
      id,
      sourceId,
      sourceName,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }
}
