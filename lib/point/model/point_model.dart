import 'package:json_annotation/json_annotation.dart';
import 'package:intermission_project/common/model/model_with_id.dart';

part 'point_model.g.dart';

@JsonSerializable()
class PointModel implements IModelWithId {
  @override
  final int id;
  final String pointStatus;
  final int pointChangeBalance;
  final int pointCurrentBalance;
  final int pointPreviousBalance;
  final String pointEventType;
  final String createdDate;
  final String expireTime;
  final String? pointEventName;

  PointModel({
    required this.id,
    required this.pointStatus,
    required this.pointChangeBalance,
    required this.pointCurrentBalance,
    required this.pointPreviousBalance,
    required this.pointEventType,
    required this.createdDate,
    required this.expireTime,
    this.pointEventName,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) => _$PointModelFromJson(json);

  Map<String, dynamic> toJson() => _$PointModelToJson(this);
}
