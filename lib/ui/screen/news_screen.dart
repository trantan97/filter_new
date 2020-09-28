import 'package:filter_news/data/repositories/news_repository.dart';
import 'package:filter_news/data/source/remote/response/news_response.dart';
import 'package:filter_news/ui/screen/detail_news_screen.dart';
import 'package:filter_news/ui/widget/item_news.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with AutomaticKeepAliveClientMixin{
  NewsRepository repository;

  @override
  void initState() {
    super.initState();
    repository = NewsRepository.instance;
    repository.topNews();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NewsResponse>(
      stream: repository.searchStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var listNews = snapshot.data.articles;
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ItemNews(
                news: listNews[index],
                onClick: () {
                  Navigator.of(context).push(DetailNewsScreen.getPage(listNews[index]));
                },
                onLongClick: () {
                  repository.saveNews(listNews[index]);
                },
              );
            },
            separatorBuilder: (context, index) => Divider(height: 1, thickness: 1, endIndent: 40, indent: 40),
            itemCount: listNews.length,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Vui lòng thử lại!"),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
  @override
  bool get wantKeepAlive => true;
}
