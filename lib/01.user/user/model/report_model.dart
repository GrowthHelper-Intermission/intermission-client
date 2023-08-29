import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel implements IModelWithId{
  final String id;          // 게시물 ID
  final String mainTitle;   // Title of the notification
  final String postDate;    // Posting date of the notification
  final String isAnswer;

  ReportModel({
    required this.id,
    required this.mainTitle,
    required this.postDate,
    required this.isAnswer,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
