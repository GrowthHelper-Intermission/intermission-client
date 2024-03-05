import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenRefreshResponse {
  final String accessToken;

  TokenRefreshResponse({
    required this.accessToken,
  });
  factory TokenRefreshResponse.fromJson(Map<String, dynamic> json)
  => _$TokenRefreshResponseFromJson(json);
}