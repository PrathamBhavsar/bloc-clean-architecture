import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_app/features/daily_news/presentation/pages/saved_articles/saved_articles.dart';

import '../../features/daily_news/data/models/article.dart';
import '../../features/daily_news/presentation/pages/article_detail/article_detail.dart';

final GoRouter router = GoRouter(
  initialLocation: "/DailyNews",
  routes: [
    GoRoute(
      path: "/DailyNews",
      builder: (context, state) => const DailyNews(),
    ),
    GoRoute(
      path: "/ArticleDetails",
      builder: (context, state) {
        final article = state.extra;
        if (article is ArticleModel) {
          return ArticleDetailsView(article: article);
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Invalid article data"),
            ),
          );
        }
      },
    ),
    GoRoute(
      path: "/SavedArticles",
      builder: (context, state) => const SavedArticles(),
    ),
  ],
);
