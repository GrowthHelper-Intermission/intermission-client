import 'package:json_annotation/json_annotation.dart';

part 'friend_code_response.g.dart';

@JsonSerializable()
class FriendCodeResponse {
  final String data;

  FriendCodeResponse({
    required this.data,
  });

  factory FriendCodeResponse.fromJson(Map<String, dynamic> json) => _$FriendCodeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FriendCodeResponseToJson(this);
}
