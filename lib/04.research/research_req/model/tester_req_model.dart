import 'package:json_annotation/json_annotation.dart';

part 'tester_req_model.g.dart';

@JsonSerializable()
class TesterReqModel {
  final String taskTpCd; // 대표자
  final String compNm; // 카카오
  final String completeUrl; // "저희가 만든 유알엘이랍니다"
  final String fgiTarget; // 오프라인, 서울 중구
  final String fgiMethod; // 1시간 5명 FGI 같은 날 2회 연속
  final String preferredTime; // “평일 오전”
  final String exceptTimeCnt; // 10

  TesterReqModel({
    required this.taskTpCd,
    required this.compNm,
    required this.completeUrl,
    required this.fgiTarget,
    required this.fgiMethod,
    required this.preferredTime,
    required this.exceptTimeCnt,
  });

  factory TesterReqModel.fromJson(Map<String, dynamic> json) =>
      _$TesterReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$TesterReqModelToJson(this);
}
