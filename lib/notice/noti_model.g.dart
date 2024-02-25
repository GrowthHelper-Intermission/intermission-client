// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noti_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotiModel _$NotiModelFromJson(Map<String, dynamic> json) => NotiModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      postDate: json['postDate'] as String,
    );

Map<String, dynamic> _$NotiModelToJson(NotiModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'postDate': instance.postDate,
    };
