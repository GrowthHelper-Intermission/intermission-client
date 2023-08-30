
import 'package:json_annotation/json_annotation.dart';

part 'single_comment.g.dart';

@JsonSerializable()
class SingleComment{
  final String content;

  SingleComment({
    required this.content,
});
  factory SingleComment.fromJson(Map<String, dynamic> json)
  => _$SingleCommentFromJson(json);

  Map<String, dynamic> toJson() => _$SingleCommentToJson(this);
}