import 'package:intermission_project/04.research/research/model/noti_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'research_report_model.g.dart';

@JsonSerializable()
class ResearchReportModel{
  final String id;
  final String content;

  ResearchReportModel({
    required this.id,
    required this.content,
  });

  factory ResearchReportModel.fromJson(Map<String, dynamic> json)
  => _$ResearchReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResearchReportModelToJson(this);

  // `copyWith` 메서드 추가
  ResearchReportModel copyWith({
    String? id,
    String? content,
  }) {
    return ResearchReportModel(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }
}
