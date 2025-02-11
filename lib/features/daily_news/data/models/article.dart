import "package:floor/floor.dart";
import "package:news_app/features/daily_news/domain/entities/article.dart";

/// The model class that extends the domain entity and adds JSON conversion.

@Entity(tableName: 'article', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  final String? sourceId;
  final String? sourceName;

  const ArticleModel({
    this.sourceId,
    this.sourceName,
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) : super(
          id: id,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      sourceId: map["source"]?["id"] as String?,
      sourceName: map["source"]?["name"] as String?,
      author: map["author"] ?? "",
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      url: map["url"] ?? "",
      urlToImage: map["urlToImage"] ?? "",
      publishedAt: map["publishedAt"] ?? "",
      content: map["content"] ?? "",
    );
  }
}
