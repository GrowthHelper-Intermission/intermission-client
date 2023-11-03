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
      fgiTarget: json['fgiTarget'] as String,
      fgiMethod: json['fgiMethod'] as String,
      preferredTime: json['preferredTime'] as String,
      exceptTimeCnt: json['exceptTimeCnt'] as String,
    );

Map<String, dynamic> _$TesterReqModelToJson(TesterReqModel instance) =>
    <String, dynamic>{
      'taskTpCd': instance.taskTpCd,
      'compNm': instance.compNm,
      'completeUrl': instance.completeUrl,
      'fgiTarget': instance.fgiTarget,
      'fgiMethod': instance.fgiMethod,
      'preferredTime': instance.preferredTime,
      'exceptTimeCnt': instance.exceptTimeCnt,
    };
