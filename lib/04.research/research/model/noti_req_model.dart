import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'noti_req_model.g.dart';

@JsonSerializable()
class NotiReqModel{
  final String mainTitle;   // Title of the notification
  final String detail;    // Posting date of the notification

  NotiReqModel({
    required this.mainTitle,
    required this.detail,
  });

  factory NotiReqModel.fromJson(Map<String, dynamic> json) => _$NotiReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotiReqModelToJson(this);
}
