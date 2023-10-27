// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_change_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordChangeModel _$PasswordChangeModelFromJson(Map<String, dynamic> json) =>
    PasswordChangeModel(
      checkPassword: json['checkPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$PasswordChangeModelToJson(
        PasswordChangeModel instance) =>
    <String, dynamic>{
      'checkPassword': instance.checkPassword,
      'newPassword': instance.newPassword,
    };
