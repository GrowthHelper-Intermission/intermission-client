import 'package:json_annotation/json_annotation.dart';

part 'point_change_response.g.dart';

@JsonSerializable()
class PointChangeResponse {
  final int code;
  final String? httpStatus;
  final String? message;
  final String? data;

  PointChangeResponse({
    required this.code,
    this.httpStatus,
    required this.message,
    this.data, // As an optional field
  });

  // JSON serialization logic
  factory PointChangeResponse.fromJson(Map<String, dynamic> json) => _$PointChangeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PointChangeResponseToJson(this);
}
