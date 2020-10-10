import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

const String TABLE_NEWS = "table_news";

@JsonSerializable()
@Entity(tableName: TABLE_NEWS)
class News {
  @primaryKey
  String url;
  String title;
  String description;
  String urlToImage;
  String author;
  String localPath;

  @JsonKey(defaultValue: 0)
  int isFavorite;

  News(this.title, this.description, this.url, this.urlToImage, this.author, this.localPath, this.isFavorite);

  Map<String, dynamic> toJson() {
    return _$NewsToJson(this);
  }

  static News fromJson(Map<String, dynamic> json) {
    return _$NewsFromJson(json);
  }
}
