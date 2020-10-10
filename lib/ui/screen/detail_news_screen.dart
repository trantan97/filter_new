import 'package:filter_news/data/model/news.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailNewsScreen extends StatefulWidget {
  final String url;

  const DetailNewsScreen({Key key, this.url}) : super(key: key);

  @override
  _DetailNewsScreenState createState() => _DetailNewsScreenState();

  static MaterialPageRoute getPage(String url) {
    return MaterialPageRoute(
      builder: (context) => DetailNewsScreen(url: url),
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
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (url) {
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
