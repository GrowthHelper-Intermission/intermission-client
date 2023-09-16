// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tester_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TesterReqModel _$TesterReqModelFromJson(Map<String, dynamic> json) =>
    TesterReqModel(
      taskTpCd: json['taskTpCd'] as String,
      compNm: json['compNm'] as String,
      completeUrl: json['completeUrl'] as String,
      researchMethTpCd: json['researchMethTpCd'] as String,
      exceptCountTime: json['exceptCountTime'] as String,
      preferredTime: json['preferredTime'] as String,
      isAgree: json['isAgree'] as String,
      researchEntryCnt: json['researchEntryCnt'] as String,
    );

Map<String, dynamic> _$TesterReqModelToJson(TesterReqModel instance) =>
    <String, dynamic>{
      'taskTpCd': instance.taskTpCd,
      'compNm': instance.compNm,
      'completeUrl': instance.completeUrl,
      'researchMethTpCd': instance.researchMethTpCd,
      'exceptCountTime': instance.exceptCountTime,
      'preferredTime': instance.preferredTime,
      'isAgree': instance.isAgree,
      'researchEntryCnt': instance.researchEntryCnt,
    };
