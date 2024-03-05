import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point_change_model.g.dart';

@JsonSerializable()
class PointChangeModel{
  final int point;

  PointChangeModel({
    required this.point
  });

  factory PointChangeModel.fromJson(Map<String, dynamic> json) => _$PointChangeModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointChangeModelToJson(this);
}
