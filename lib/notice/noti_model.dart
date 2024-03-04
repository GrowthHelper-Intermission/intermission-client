import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'noti_model.g.dart';

@JsonSerializable()
class NotiModel implements IModelWithId {
  final int id;          // 게시물 ID
  final String title;   // Title of the notification
  final String content;
  final String postDate;    // Posting date of the notification

  NotiModel({
    required this.id,
    required this.title,
    required this.content,
    required this.postDate,
  });

  factory NotiModel.fromJson(Map<String, dynamic> json) => _$NotiModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotiModelToJson(this);
}
