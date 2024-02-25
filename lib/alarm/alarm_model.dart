import 'package:json_annotation/json_annotation.dart';

part 'alarm_model.g.dart';

@JsonSerializable()
class AlarmModel {
  final String body;
  final String title;

  AlarmModel({
    required this.body,
    required this.title,
  });

  // JSON serialization logic
  factory AlarmModel.fromJson(Map<String, dynamic> json) => _$AlarmModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmModelToJson(this);
}
