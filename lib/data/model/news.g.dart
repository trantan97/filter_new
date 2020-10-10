// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    json['title'] as String,
    json['description'] as String,
    json['url'] as String,
    json['urlToImage'] as String,
    json['author'] as String,
    json['localPath'] as String,
    json['isFavorite'] as int ?? 0,
  );
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'description': instance.description,
      'urlToImage': instance.urlToImage,
      'author': instance.author,
      'localPath': instance.localPath,
      'isFavorite': instance.isFavorite,
    };
