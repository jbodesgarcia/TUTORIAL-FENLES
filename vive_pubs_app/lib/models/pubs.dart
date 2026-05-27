import 'package:json_annotation/json_annotation.dart';
import 'package:vive_pubs_app/models/pub_picture.dart';
part 'pubs.g.dart';

@JsonSerializable(explicitToJson: true)
class Pubs {
  Pubs({
    required this.id,
    required this.name,
    required this.address,
    required this.picture,
    required this.avgPrice,
  });

  final int id;
  final String name;
  final String address;
  final PubPicture picture;
  final int avgPrice;

  factory Pubs.fromJson(Map<String, dynamic> json) => _$PubsFromJson(json);

  Map<String, dynamic> toJson() => _$PubsToJson(this);
}