import 'package:json_annotation/json_annotation.dart';
part 'pub_picture.g.dart';

@JsonSerializable(explicitToJson: true)
class PubPicture {
  PubPicture({required this.id, required this.name, required this.url});

  final int id;
  final String name;
  final String url;

  factory PubPicture.fromJson(Map<String, dynamic> json) =>
      _$PubPictureFromJson(json);

  Map<String, dynamic> toJson() => _$PubPictureToJson(this);
}