
import 'package:json_annotation/json_annotation.dart';

part 'single_comment_model.g.dart';

@JsonSerializable()
class SingleCommentModel{
  final String content;

  SingleCommentModel({
    required this.content,
});
  factory SingleCommentModel.fromJson(Map<String, dynamic> json)
  => _$SingleCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$SingleCommentModelToJson(this);
}