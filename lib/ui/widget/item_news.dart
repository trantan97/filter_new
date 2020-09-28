import 'package:cached_network_image/cached_network_image.dart';
import 'package:filter_news/data/model/news.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class ItemNews extends StatelessWidget {
  final News news;
  final VoidCallback onClick;

  const ItemNews({Key key, this.news, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 100),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OptimizedCacheImage(
              fit: BoxFit.cover,
              imageUrl: news.urlToImage ?? "",
              imageBuilder: (context, imageProvider) => Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8)],
                ),
              ),
              placeholder: (context, url) => placeholder,
              errorWidget: (context, url, error) => errorView,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    news.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    news.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get placeholder {
    return SizedBox(
      width: 70,
      height: 70,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
      ),
    );
  }

  Widget get errorView {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8)],
      ),
      child: Icon(Icons.error_outline, color: Colors.white70),
    );
  }
}
