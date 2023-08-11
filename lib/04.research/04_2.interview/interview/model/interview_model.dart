import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_model.g.dart';

enum onlineCategory{
  online,
  offline,
  both,
}

@JsonSerializable()
class InterviewModel implements IModelWithId {
  final String id; // PK
  final String mainTitle; // ex)뇌졸중 환자 및 보호자
  final String subTitle; //ex)온라인, 서울 관악구 기준 30분 거리면 오프라인 방문 가능
  final onlineCategory isOnline; //대면여부
  final String hourlyRate; //1시간 3만원
  final String dueDate; //yyyy-mm-dd
  final String isOnGoing; //진행여부

  InterviewModel({
    required this.id,
    required this.mainTitle,
    required this.subTitle,
    required this.dueDate,
    required this.isOnline,
    required this.hourlyRate,
    required this.isOnGoing,
  });

  factory InterviewModel.fromJson(Map<String, dynamic> json)
  => _$InterviewModelFromJson(json);

  Map<String,dynamic> toJson() => _$InterviewModelToJson(this);
}