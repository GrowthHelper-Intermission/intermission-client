// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyReqModel _$SurveyReqModelFromJson(Map<String, dynamic> json) =>
    SurveyReqModel(
      taskTpCd: json['taskTpCd'] as String,
      screening: json['screening'] as String,
      completeUrl: json['completeUrl'] as String,
      exceptCountTime: json['exceptCountTime'] as String,
      researchEntryCnt: json['researchEntryCnt'] as String,
      surveyInput: json['surveyInput'] as String,
      surveyRes: json['surveyRes'] as String,
      surveyDev: json['surveyDev'] as String,
      isAgree: json['isAgree'] as String,
    );

Map<String, dynamic> _$SurveyReqModelToJson(SurveyReqModel instance) =>
    <String, dynamic>{
      'taskTpCd': instance.taskTpCd,
      'screening': instance.screening,
      'completeUrl': instance.completeUrl,
      'exceptCountTime': instance.exceptCountTime,
      'researchEntryCnt': instance.researchEntryCnt,
      'surveyInput': instance.surveyInput,
      'surveyRes': instance.surveyRes,
      'surveyDev': instance.surveyDev,
      'isAgree': instance.isAgree,
    };
