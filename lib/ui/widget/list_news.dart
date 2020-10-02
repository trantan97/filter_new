import 'package:filter_news/data/model/news.dart';
import 'package:filter_news/data/source/remote/response/news_response.dart';
import 'package:filter_news/ui/widget/item_news.dart';
import 'package:flutter/material.dart';

class ListNews extends StatelessWidget {
  final Stream stream;
  final Function(News news) onClick;
  final Function(News news, Offset offset) onLongClick;

  const ListNews({Key key, this.stream, this.onClick, this.onLongClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var listNews;
          if (snapshot.data is NewsResponse) {
            NewsResponse newsResponse = snapshot.data;
            listNews = newsResponse.articles;
          } else {
            listNews = snapshot.data;
          }
          if (listNews.isEmpty) {
            return Center(
              child: Text("Trống!"),
            );
          }
          return ListView.separated(
            key: UniqueKey(),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ItemNews(
                news: listNews[index],
                onClick: () {
                  onClick(listNews[index]);
                },
                onLongClick: (offset) {
                  onLongClick(listNews[index], offset);
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
}
