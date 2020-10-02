import 'package:filter_news/data/model/news.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_response.g.dart';

@JsonSerializable()
class NewsResponse {
  num totalResults;
  List<News> articles;

  static NewsResponse fromJson(Map<String, dynamic> json, {String keyword}) {
    return _$NewsResponseFromJson(json);
  }
}
