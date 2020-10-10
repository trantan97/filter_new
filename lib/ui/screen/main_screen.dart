import 'package:filter_news/data/repositories/news_repository.dart';
import 'package:filter_news/ui/screen/favorite_screen.dart';
import 'package:filter_news/ui/screen/news_screen.dart';
import 'package:filter_news/ui/screen/saved_news_screen.dart';
import 'package:filter_news/ui/widget/search_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  TabController tabController;
  NewsRepository repository;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    repository = NewsRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        title: "Lọc tin tức",
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(child: Text("Tin tức")),
            Tab(child: Text("Đã lưu")),
            Tab(child: Text("Yêu thích")),
          ],
        ),
        onSearch: (keyWord) {
          repository.search(keyWord);
        },
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          NewsScreen(),
          SavedNewsScreen(),
          FavoriteScreen(),
        ],
      ),
    );
  }
}
