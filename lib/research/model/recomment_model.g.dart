// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recomment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReComment _$ReCommentFromJson(Map<String, dynamic> json) => ReComment(
      userId: json['userId'] as int,
      reCommentId: json['reCommentId'] as int,
      writer: json['writer'] as String?,
      content: json['content'] as String?,
      createdDate: json['createdDate'] as String,
      isUpdate: json['isUpdate'] as String?,
      isMyComment: json['isMyComment'] as String?,
    );

Map<String, dynamic> _$ReCommentToJson(ReComment instance) => <String, dynamic>{
      'userId': instance.userId,
      'reCommentId': instance.reCommentId,
      'writer': instance.writer,
      'content': instance.content,
      'createdDate': instance.createdDate,
      'isUpdate': instance.isUpdate,
      'isMyComment': instance.isMyComment,
    };
