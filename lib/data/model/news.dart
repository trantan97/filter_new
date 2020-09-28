import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  num id;
  String title;
  String description;
  String url;
  String urlToImage;
  String author;

  Map<String, dynamic> toJson() {
    return _$NewsToJson(this);
  }

  static News fromJson(Map<String, dynamic> json) {
    return _$NewsFromJson(json);
  }
}
