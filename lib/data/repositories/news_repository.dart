import 'dart:async';

import 'package:dio/dio.dart';
import 'package:filter_news/data/model/news.dart';
import 'package:filter_news/data/source/remote/api_const.dart';
import 'package:filter_news/data/source/remote/network.dart';
import 'package:filter_news/data/source/remote/response/news_response.dart';

class NewsRepository {
  static NewsRepository _instance;
  StreamController<NewsResponse> searchStream;
  Network _network;

  static NewsRepository get instance {
    _instance ??= NewsRepository._();
    return _instance;
  }

  NewsRepository._() {
    _network = Network();
    searchStream = StreamController();
  }

  Future<void> close() {
    return searchStream.close();
  }

  Future<void> search(String keyWord) async {
    Response response = await _network.get(url: ApiConst.API_SEARCH, params: {"q": keyWord});
    var newsResponse = NewsResponse.fromJson(response.data);
    searchStream.add(newsResponse);
  }

  Future<void> topNews({String countryCode = "us"}) async {
    Response response = await _network.get(url: ApiConst.API_TOP_NEWS, params: {"country": countryCode});
    var newsResponse = NewsResponse.fromJson(response.data);
    searchStream.add(newsResponse);
  }

  Future<void> saveNews(News news) async {
    Response response = await _network.get(url: news.url);
    print(response.data);
  }
}
