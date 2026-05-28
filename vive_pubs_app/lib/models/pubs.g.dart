// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pubs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pubs _$PubsFromJson(Map<String, dynamic> json) => Pubs(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  address: json['address'] as String,
  picture: PubPicture.fromJson(json['picture'] as Map<String, dynamic>),
  avgPrice: (json['avgPrice'] as num).toInt(),
);

Map<String, dynamic> _$PubsToJson(Pubs instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'picture': instance.picture.toJson(),
  'avgPrice': instance.avgPrice,
};
