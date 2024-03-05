import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse {
  final int code;
  final String message;
  final String? data;

  CommonResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json)
  => _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}


