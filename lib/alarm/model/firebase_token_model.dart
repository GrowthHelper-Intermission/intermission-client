
import 'package:json_annotation/json_annotation.dart';

part 'firebase_token_model.g.dart';

@JsonSerializable()
class FirebaseTokenModel {
  String firebaseToken;

  FirebaseTokenModel({required this.firebaseToken});

  factory FirebaseTokenModel.fromJson(Map<String, dynamic> json) => _$FirebaseTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseTokenModelToJson(this);
}
