

import 'package:json_annotation/json_annotation.dart';

part 'point_model.g.dart';

@JsonSerializable()
class PointModel {
  final int? userPoint;
  final String? userId;
  final String? pointDate;
  final String? researchId;

  PointModel({
    this.userPoint,
    this.userId,
    this.pointDate,
    this.researchId,
  });
}
