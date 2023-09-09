import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  final String code;
  final String message;
  final String? data;

  PostResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json)
  => _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}


