
import 'package:json_annotation/json_annotation.dart';

part 'password_change.g.dart';

@JsonSerializable()
class PasswordChangeModel {
  final String? checkPassword;
  final String? newPassword;

  PasswordChangeModel({this.checkPassword, this.newPassword});
}
