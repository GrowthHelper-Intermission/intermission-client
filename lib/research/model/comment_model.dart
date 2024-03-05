import 'package:intermission_project/research/model/recomment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class Comment{
  final int userId;
  final int commentId;
  final String? writer;
  final String? content;
  final String createdDate;
  final String? isUpdate;
  final String? isMyComment;
  final List<ReComment> reComments;

  Comment({
    required this.userId,
    required this.commentId,
    this.writer,
    this.content,
    required this.createdDate,
    this.isUpdate,
    required this.reComments,
    required this.isMyComment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
