// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_req_chn_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewReqChn _$InterviewReqChnFromJson(Map<String, dynamic> json) =>
    InterviewReqChn(
      intvReqDay: json['intvReqDay'] as String,
      intvReqSeqNo: json['intvReqSeqNo'] as String,
      chnCd: json['chnCd'] as String,
      remark: json['remark'] as String?,
      delYn: json['delYn'] as String?,
      frstRegtDt: json['frstRegtDt'] == null
          ? null
          : DateTime.parse(json['frstRegtDt'] as String),
      finlUpdtDt: json['finlUpdtDt'] == null
          ? null
          : DateTime.parse(json['finlUpdtDt'] as String),
    );

Map<String, dynamic> _$InterviewReqChnToJson(InterviewReqChn instance) =>
    <String, dynamic>{
      'intvReqDay': instance.intvReqDay,
      'intvReqSeqNo': instance.intvReqSeqNo,
      'chnCd': instance.chnCd,
      'remark': instance.remark,
      'delYn': instance.delYn,
      'frstRegtDt': instance.frstRegtDt?.toIso8601String(),
      'finlUpdtDt': instance.finlUpdtDt?.toIso8601String(),
    };
