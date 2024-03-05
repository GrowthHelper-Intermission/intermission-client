// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteUserModel _$DeleteUserModelFromJson(Map<String, dynamic> json) =>
    DeleteUserModel(
      deleteDescription: json['deleteDescription'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$DeleteUserModelToJson(DeleteUserModel instance) =>
    <String, dynamic>{
      'deleteDescription': instance.deleteDescription,
      'password': instance.password,
    };
