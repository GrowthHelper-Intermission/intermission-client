import 'package:intermission_project/04.research/research/model/noti_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'noti_detail_model.g.dart';

@JsonSerializable()
class NotiDetailModel extends NotiModel {
  final String detail;

  NotiDetailModel({
    required super.id,
    required super.mainTitle,
    required super.postDate,
    required this.detail,
  });

  factory NotiDetailModel.fromJson(Map<String, dynamic> json) => _$NotiDetailModelFromJson(json);

  // Map<String, dynamic> toJson() => _$NotiDetailModelToJson(this);
}
