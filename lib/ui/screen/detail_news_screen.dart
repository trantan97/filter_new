import 'package:filter_news/data/model/news.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailNewsScreen extends StatefulWidget {
  final News news;

  const DetailNewsScreen({Key key, this.news}) : super(key: key);

  @override
  _DetailNewsScreenState createState() => _DetailNewsScreenState();

  static MaterialPageRoute getPage(News news) {
    return MaterialPageRoute(
      builder: (context) => DetailNewsScreen(news: news),
    );
  }
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.news.url,
              onPageFinished: (url) {
                setState(() {
                  loaded = true;
                });
              },
            ),
            if (loaded == false) Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
