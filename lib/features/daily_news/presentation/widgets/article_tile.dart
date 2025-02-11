import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    super.key,
    required this.article,
    this.isRemovable = false,
    this.onRemove,
    this.onArticlePressed,
  });

  final ArticleEntity? article;
  final bool isRemovable;
  final void Function(ArticleModel article)? onRemove;
  final void Function(ArticleModel article)? onArticlePressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onArticlePressed != null && article is ArticleModel) {
          onArticlePressed!(article as ArticleModel);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.width / 2.2,
          child: Row(
            children: [
              _buildImage(context),
              Expanded(
                child: Stack(
                  children: [
                    _buildTitleAndDescription(),
                    if (isRemovable) _buildRemoveButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            article?.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              article?.description ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.timeline_outlined, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                article?.publishedAt ?? "",
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveButton() {
    return Positioned(
      top: 4,
      right: 4,
      child: GestureDetector(
        onTap: () {
          if (onRemove != null && article is ArticleModel) {
            onRemove!(article as ArticleModel);
          }
        },
        child: const CircleAvatar(
          radius: 14,
          backgroundColor: Colors.red,
          child: Icon(Icons.close, color: Colors.white, size: 16),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article?.urlToImage ?? "",
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.7,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.7,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.08)),
          child: const Icon(Icons.error, color: Colors.red),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2.7,
          height: double.infinity,
          child: const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
