import 'package:json_annotation/json_annotation.dart';

part 'friend_code_model.g.dart';

@JsonSerializable()
class FriendCodeModel {
  final String data;

  FriendCodeModel({
    required this.data,
  });

  // JSON serialization logic
  factory FriendCodeModel.fromJson(Map<String, dynamic> json) => _$FriendCodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$FriendCodeModelToJson(this);
}
