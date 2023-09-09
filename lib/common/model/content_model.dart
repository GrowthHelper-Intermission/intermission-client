import 'package:json_annotation/json_annotation.dart';

part 'content_model.g.dart';

@JsonSerializable()
class ContentModel{
  final String content;

  ContentModel({
    required this.content,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json)
  => _$ContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentModelToJson(this);

  // `copyWith` 메서드 추가
  ContentModel copyWith({
    String? content,
  }) {
    return ContentModel(
      content: content ?? this.content,
    );
  }
}
