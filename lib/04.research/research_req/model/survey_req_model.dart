import 'package:json_annotation/json_annotation.dart';

part 'survey_req_model.g.dart';

@JsonSerializable()
class SurveyReqModel {
  final String taskTpCd; // 대표자
  final String screening; // "10,20대만 해주시구요 남성해주세요"
  final String completeUrl; // "저희가 만든 유알엘이랍니다"
  final String exceptCountTime; // "40개 물을거고요 20분정도 걸릴듯"
  final String researchEntryCnt; // 10
  final String surveyInput;
  final String surveyRes; // "Y"
  final String surveyDev; // "Y"
  final String isAgree; // "Y"

  SurveyReqModel({
    required this.taskTpCd,
    required this.screening,
    required this.completeUrl,
    required this.exceptCountTime,
    required this.researchEntryCnt,
    required this.surveyInput,
    required this.surveyRes,
    required this.surveyDev,
    required this.isAgree,
  });

  factory SurveyReqModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyReqModelToJson(this);
}
