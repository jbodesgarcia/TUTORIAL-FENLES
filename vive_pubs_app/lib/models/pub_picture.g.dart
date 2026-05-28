// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pub_picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PubPicture _$PubPictureFromJson(Map<String, dynamic> json) => PubPicture(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$PubPictureToJson(PubPicture instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };
