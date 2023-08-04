// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmSetModel _$AlarmSetModelFromJson(Map<String, dynamic> json) =>
    AlarmSetModel(
      membNo: json['membNo'] as String,
      notiTpCd: json['notiTpCd'] as String,
      applStrtDay: json['applStrtDay'] as String,
      applEndDay: json['applEndDay'] as String?,
      delYn: json['delYn'] as String?,
      frstRegtDt: json['frstRegtDt'] == null
          ? null
          : DateTime.parse(json['frstRegtDt'] as String),
      frstRegtEmpNo: json['frstRegtEmpNo'] as String?,
      finlUpdtDt: json['finlUpdtDt'] == null
          ? null
          : DateTime.parse(json['finlUpdtDt'] as String),
      finlUpdtEmpNo: json['finlUpdtEmpNo'] as String?,
    );

Map<String, dynamic> _$AlarmSetModelToJson(AlarmSetModel instance) =>
    <String, dynamic>{
      'membNo': instance.membNo,
      'notiTpCd': instance.notiTpCd,
      'applStrtDay': instance.applStrtDay,
      'applEndDay': instance.applEndDay,
      'delYn': instance.delYn,
      'frstRegtDt': instance.frstRegtDt?.toIso8601String(),
      'frstRegtEmpNo': instance.frstRegtEmpNo,
      'finlUpdtDt': instance.finlUpdtDt?.toIso8601String(),
      'finlUpdtEmpNo': instance.finlUpdtEmpNo,
    };
