
import 'package:json_annotation/json_annotation.dart';

part 'password_change_model.g.dart';

@JsonSerializable()
class PasswordChangeModel {
  final String? checkPassword;
  final String? newPassword;

  PasswordChangeModel({this.checkPassword, this.newPassword});

  factory PasswordChangeModel.fromJson(Map<String, dynamic> json)
  => _$PasswordChangeModelFromJson(json);

  Map<String,dynamic> toJson() => _$PasswordChangeModelToJson(this);
}
