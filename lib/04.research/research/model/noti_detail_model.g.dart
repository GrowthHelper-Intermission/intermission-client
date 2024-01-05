// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noti_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotiDetailModel _$NotiDetailModelFromJson(Map<String, dynamic> json) =>
    NotiDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      postDate: json['postDate'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$NotiDetailModelToJson(NotiDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'postDate': instance.postDate,
    };
