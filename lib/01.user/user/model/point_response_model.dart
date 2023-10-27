import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point_response_model.g.dart';

@JsonSerializable()
class PointResponse {
  final Meta meta;
  final List<PointModel> data;

  PointResponse({
    required this.meta,
    required this.data,
  });

  factory PointResponse.fromJson(Map<String, dynamic> json) => _$PointResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PointResponseToJson(this);
}

@JsonSerializable()
class Meta {
  final int count;
  final bool hasMore;
  final int totalPoint;

  Meta({
    required this.count,
    required this.hasMore,
    required this.totalPoint,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
