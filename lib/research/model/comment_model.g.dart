// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      userId: json['userId'] as int,
      commentId: json['commentId'] as int,
      writer: json['writer'] as String?,
      content: json['content'] as String?,
      createdDate: json['createdDate'] as String,
      isUpdate: json['isUpdate'] as String?,
      reComments: (json['reComments'] as List<dynamic>)
          .map((e) => ReComment.fromJson(e as Map<String, dynamic>))
          .toList(),
      isMyComment: json['isMyComment'] as String?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'userId': instance.userId,
      'commentId': instance.commentId,
      'writer': instance.writer,
      'content': instance.content,
      'createdDate': instance.createdDate,
      'isUpdate': instance.isUpdate,
      'isMyComment': instance.isMyComment,
      'reComments': instance.reComments,
    };
