import 'package:json_annotation/json_annotation.dart';

part 'delete_user_model.g.dart';

@JsonSerializable()
class DeleteUserModel {
  final String deleteDescription;
  final String password;

  DeleteUserModel({
    required this.deleteDescription,
    required this.password,
  });

  // JSON serialization logic
  factory DeleteUserModel.fromJson(Map<String, dynamic> json) => _$DeleteUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteUserModelToJson(this);
}
