import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'noti_model.g.dart';

@JsonSerializable()
class NotiModel implements IModelWithId {
  final String id;          // 게시물 ID
  final String mainTitle;   // Title of the notification
  final String postDate;    // Posting date of the notification

  NotiModel({
    required this.id,
    required this.mainTitle,
    required this.postDate,
  });

  factory NotiModel.fromJson(Map<String, dynamic> json) => _$NotiModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotiModelToJson(this);
}
