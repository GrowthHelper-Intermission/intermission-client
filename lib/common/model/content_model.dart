import 'package:json_annotation/json_annotation.dart';

part 'content_model.g.dart';

@JsonSerializable()
class ContentModel{
  final String reportContent;

  ContentModel({
    required this.reportContent,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json)
  => _$ContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentModelToJson(this);

  // `copyWith` 메서드 추가
  ContentModel copyWith({
    String? reportContent,
  }) {
    return ContentModel(
      reportContent: reportContent ?? this.reportContent,
    );
  }
}
