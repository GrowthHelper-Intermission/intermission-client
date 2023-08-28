// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noti_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotiDetailModel _$NotiDetailModelFromJson(Map<String, dynamic> json) =>
    NotiDetailModel(
      id: json['id'] as String,
      mainTitle: json['mainTitle'] as String,
      postDate: json['postDate'] as String,
      detail: json['detail'] as String,
    );

Map<String, dynamic> _$NotiDetailModelToJson(NotiDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'postDate': instance.postDate,
      'detail': instance.detail,
    };
