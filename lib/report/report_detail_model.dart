import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:intermission_project/report/report_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_detail_model.g.dart';

@JsonSerializable()
class ReportDetailModel extends ReportModel {
  final String detail;

  ReportDetailModel({
    required super.id,
    required super.mainTitle,
    required super.postDate,
    required super.isAnswer,
    required this.detail,
  });

  factory ReportDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ReportDetailModelFromJson(json);
}