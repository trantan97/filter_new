import 'package:filter_news/data/repositories/news_repository.dart';
import 'package:filter_news/data/source/remote/response/news_response.dart';
import 'package:filter_news/ui/screen/detail_news_screen.dart';
import 'package:filter_news/ui/widget/item_news.dart';
import 'package:filter_news/ui/widget/list_news.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with AutomaticKeepAliveClientMixin {
  NewsRepository repository;

  @override
  void initState() {
    super.initState();
    repository = NewsRepository.instance;
    repository.topNews();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListNews(
      stream: repository.searchStream.stream,
      onClick: (news) {
        Navigator.of(context).push(DetailNewsScreen.getPage(news.url));
      },
      onLongClick: (news, offset) async {
        _showDownLoadDialog();
        await repository.saveNews(news);
        Navigator.of(context).pop();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  _showDownLoadDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Save News"),
          content: SizedBox(height: 150, child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
