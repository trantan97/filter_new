import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:filter_news/data/model/news.dart';
import 'package:filter_news/data/source/local/dao/news_dao.dart';
import 'package:filter_news/data/source/local/database.dart';
import 'package:filter_news/data/source/remote/api_const.dart';
import 'package:filter_news/data/source/remote/network.dart';
import 'package:filter_news/data/source/remote/response/news_response.dart';
import 'package:path_provider/path_provider.dart';

class NewsRepository {
  static NewsRepository _instance;
  StreamController<NewsResponse> searchStream;
  Network _network;
  NewsDao _newsDao;
  bool isLoadingMore = false;
  NewsResponse newsResponse;

  Future<NewsDao> get newsDao async {
    _newsDao ??= (await DatabaseProvider.databaseProvider).newsDao;
    return _newsDao;
  }

  static NewsRepository get instance {
    _instance ??= NewsRepository._();
    return _instance;
  }

  NewsRepository._() {
    _network = Network();
    searchStream = StreamController();
    newsDao;
  }

  Future<void> close() {
    return searchStream.close();
  }

  Future<void> search(String keyWord) async {
    Response response = await _network.get(url: ApiConst.API_SEARCH, params: {"q": keyWord, "pageSize": 100});
    newsResponse = NewsResponse.fromJson(response.data, keyword: keyWord);
    searchStream.add(newsResponse);
  }

  Future<void> topNews() async {
    Response response = await _network.get(url: ApiConst.API_TOP_NEWS, params: {"country": "us", "pageSize": 100});
    newsResponse = NewsResponse.fromJson(response.data);
    searchStream.add(newsResponse);
  }

  Stream<List<News>> getSavedNews() async* {
    final dao = await newsDao;
    yield* dao.getNewsAsStream();
  }

  Stream<List<News>> getFavoriteNews() async* {
    final dao = await newsDao;
    yield* dao.getFavoriteNewsAsStream();
  }

  Future<void> saveNews(News news, {ProgressCallback onReceiveProgress}) async {
    //download & save to file
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String newsDir = "${dir.path}/News";
      await Directory(newsDir).create(recursive: true);
      String newsPath = "$newsDir/${createFileName(news.url)}.html";
      await _network.download(
        url: news.url,
        filePath: newsPath,
        onReceiveProgress: onReceiveProgress,
      );
      //save to database
      news.localPath = newsPath;
      final dao = await newsDao;
      await dao.addNews(news);
    } catch (e) {
      print(e);
    }
  }

  Future<int> favorite(News news) async {
    news.isFavorite = 1;
    final dao = await newsDao;
    return dao.updateNews(news);
  }

  Future<int> unFavorite(News news) async {
    news.isFavorite = 0;
    final dao = await newsDao;
    return dao.updateNews(news);
  }

  Future<int> deleteNews(News news) async {
    final dao = await newsDao;
    return dao.deleteNews(news);
  }

  String createFileName(String url) {
    return url.replaceAll("/", "_");
  }
}
