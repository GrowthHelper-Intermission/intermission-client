import 'package:intermission_project/notice/model/noti_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'noti_detail_model.g.dart';

@JsonSerializable()
class NotiDetailModel extends NotiModel {

  NotiDetailModel({
    required super.id,
    required super.title,
    required super.postDate,
    required super.content,
  });

  factory NotiDetailModel.fromJson(Map<String, dynamic> json) => _$NotiDetailModelFromJson(json);

  // Map<String, dynamic> toJson() => _$NotiDetailModelToJson(this);
}
