import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_code_model.g.dart';

@JsonSerializable()
class FriendRecommendCodeModel{
  final String code;

  FriendRecommendCodeModel({
    required this.code,
  });

  factory FriendRecommendCodeModel.fromJson(Map<String, dynamic> json) => _$FriendRecommendCodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$FriendRecommendCodeModelToJson(this);
}
