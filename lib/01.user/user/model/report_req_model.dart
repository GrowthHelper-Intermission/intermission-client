import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_req_model.g.dart';

@JsonSerializable()
class ReportReqModel{
  final String mainTitle;   // Title of the notification
  final String detail;    // Posting date of the notification

  ReportReqModel({
    required this.mainTitle,
    required this.detail,
  });

  factory ReportReqModel.fromJson(Map<String, dynamic> json) => _$ReportReqModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportReqModelToJson(this);
}
