import 'package:json_annotation/json_annotation.dart';
import 'pubPicture.dart';

part 'pubs.g.dart';

@JsonSerializable(explicitToJson: true)
class Pubs {
  Pubs(
    {
      required this.id,
      required this.name,
      required this.address,
      required this.picture, required double avgPrice,
    }
  );

  final int id;
  final String name;
  final String address;
  final PubPicture picture;

  factory Pubs.fromJson(Map<String, dynamic> json) =>
      _$PubsFromJson(json);

  get avgPrice => null;

  Map<String, dynamic> toJson() => _$PubsToJson(this);

}