import 'package:filter_news/data/model/news.dart';
import 'package:filter_news/data/repositories/news_repository.dart';
import 'package:filter_news/ui/screen/detail_news_screen.dart';
import 'package:filter_news/ui/widget/list_news.dart';
import 'package:flutter/material.dart';

class SavedNewsScreen extends StatefulWidget {
  @override
  _SavedNewsScreenState createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> with AutomaticKeepAliveClientMixin {
  NewsRepository repository;

  @override
  void initState() {
    super.initState();
    repository = NewsRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListNews(
      stream: repository.getSavedNews(),
      onClick: (news) {
        Navigator.of(context).push(DetailNewsScreen.getPage(Uri.file(news.localPath).toString()));
      },
      onLongClick: (news, offset) {
        _showMenu(news, offset);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _showMenu(News news, Offset offset) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, offset.dy, 0, 0),
      items: [
        PopupMenuItem(
          height: 30,
          value: "favorite",
          child: SizedBox(width: 100, child: Text("Yêu thích")),
        ),
        PopupMenuItem(
          height: 30,
          value: "delete",
          child: Text("Xoá"),
        ),
      ],
    ).then((value) {
      switch (value) {
        case "favorite":
          {
            repository.favorite(news);
            break;
          }
        case "delete":
          {
            repository.deleteNews(news);
            break;
          }
        default:
      }
    });
  }
}
