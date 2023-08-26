// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_join_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewJoinModel _$InterviewJoinModelFromJson(Map<String, dynamic> json) =>
    InterviewJoinModel(
      intvReqDay: json['intvReqDay'] as String,
      intvReqSeqNo: json['intvReqSeqNo'] as String,
      joinMembNo: json['joinMembNo'] as String,
      scrapYn: json['scrapYn'] as String?,
      intvYn: json['intvYn'] as String?,
      delYn: json['delYn'] as String?,
      frstRegtDt: json['frstRegtDt'] == null
          ? null
          : DateTime.parse(json['frstRegtDt'] as String),
      finlUpdtDt: json['finlUpdtDt'] == null
          ? null
          : DateTime.parse(json['finlUpdtDt'] as String),
    );

Map<String, dynamic> _$InterviewJoinModelToJson(InterviewJoinModel instance) =>
    <String, dynamic>{
      'intvReqDay': instance.intvReqDay,
      'intvReqSeqNo': instance.intvReqSeqNo,
      'joinMembNo': instance.joinMembNo,
      'scrapYn': instance.scrapYn,
      'intvYn': instance.intvYn,
      'delYn': instance.delYn,
      'frstRegtDt': instance.frstRegtDt?.toIso8601String(),
      'finlUpdtDt': instance.finlUpdtDt?.toIso8601String(),
    };
