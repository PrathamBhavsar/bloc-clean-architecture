import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/main.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({super.key, required this.article});

  final ArticleEntity? article;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            _buildImage(context),
            _buildTitleAndDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              article!.title ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            Expanded(
              child: Text(
                article!.description ?? "",
                maxLines: 2,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.timeline_outlined,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  article!.publishedAt!,
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article!.urlToImage!,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.7,
          height: double.maxFinite,
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
          width: MediaQuery.of(context).size.width / 3,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
          child: Icon(Icons.error),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          height: double.maxFinite,
          child: Center(
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
