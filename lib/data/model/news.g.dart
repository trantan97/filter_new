// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News()
    ..id = json['id'] as num
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..url = json['url'] as String
    ..urlToImage = json['urlToImage'] as String
    ..author = json['author'] as String;
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'author': instance.author,
    };
