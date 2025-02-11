import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class LocalArticlesState extends Equatable {
  final List<ArticleEntity>? articles;

  const LocalArticlesState({this.articles});

  @override
  List<Object?> get props => [articles!];
}

class LocalArticlesLoading extends LocalArticlesState {}

class LocalArticleDone extends LocalArticlesState {
  const LocalArticleDone(List<ArticleEntity> articles)
      : super(articles: articles);
}
