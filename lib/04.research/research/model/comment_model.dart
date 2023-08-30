

import 'package:intermission_project/04.research/research/model/recomment_model.dart';
import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class Comment{
  final int commentId;
  final String writer;
  final String content;
  final String createdDate;
  final String isUpdate;
  final List<ReComment> reComments;

  Comment({
    required this.commentId,
    required this.writer,
    required this.content,
    required this.createdDate,
    required this.isUpdate,
    required this.reComments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
