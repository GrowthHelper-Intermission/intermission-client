import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point_model.g.dart';

@JsonSerializable()
class PointModel implements IModelWithId{
  final String id;
  final String createdAt;
  final String expireTime;
  final String pointStatus;
  final int pointAmount;
  final String researchTitle;
  final String researchType;

  PointModel({
    required this.id,
    required this.createdAt,
    required this.expireTime,
    required this.pointStatus,
    required this.pointAmount,
    required this.researchTitle,
    required this.researchType,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) => _$PointModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointModelToJson(this);
}
