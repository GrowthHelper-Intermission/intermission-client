
import 'package:json_annotation/json_annotation.dart';

part 'firebase_token_model.g.dart';

@JsonSerializable()
class FirebaseTokenModel {
  String? token;

  FirebaseTokenModel({this.token});

  factory FirebaseTokenModel.fromJson(Map<String, dynamic> json) => _$FirebaseTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseTokenModelToJson(this);
}
