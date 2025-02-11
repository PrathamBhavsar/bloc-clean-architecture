import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_tile.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/article.dart';

class SavedArticles extends HookWidget {
  const SavedArticles({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()
        ..add(
          const GetSavedArticles(),
        ),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      builder: (context, state) {
        if (state is LocalArticlesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LocalArticleDone) {
          return _buildArticlesList(state.articles!);
        }
        return Container();
      },
    );
  }

  Widget _buildArticlesList(List<ArticleEntity> articles) {
    if (articles.isEmpty) {
      return const Center(
        child: Text(
          'No saved articles!',
          style: TextStyle(color: Colors.black),
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return ArticleTile(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => _onRemoveArticle(context, article),
          onArticlePressed: (article) => _onArticlePressed(context, article),
        );
      },
    );
  }

  void _onBackButtonTapped(context) {
    context.pop();
  }

  void _onRemoveArticle(context, ArticleEntity article) {
    BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticle(article));
  }

  void _onArticlePressed(context, ArticleEntity article) {
    GoRouter.of(context).push("/ArticleDetails", extra: article);
  }
}
