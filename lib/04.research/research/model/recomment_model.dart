import 'package:json_annotation/json_annotation.dart';

part 'recomment_model.g.dart';
@JsonSerializable()
class ReComment {
  final int reCommentId;
  final String? writer;
  final String? content;
  final String createdDate;
  final String? isUpdate;
  final String? isMyComment;

  ReComment({
    required this.reCommentId,
    this.writer,
    this.content,
    required this.createdDate,
    this.isUpdate,
    this.isMyComment,
  });

  factory ReComment.fromJson(Map<String, dynamic> json) => _$ReCommentFromJson(json);
}

