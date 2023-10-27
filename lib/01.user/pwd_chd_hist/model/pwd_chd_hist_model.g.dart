// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pwd_chd_hist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PwdChgHistModel _$PwdChgHistModelFromJson(Map<String, dynamic> json) =>
    PwdChgHistModel(
      membNo: json['membNo'] as String,
      applStrtDay: json['applStrtDay'] as String,
      pwd: json['pwd'] as String,
      applEndDay: json['applEndDay'] as String?,
      delYn: json['delYn'] as String?,
      frstRegtDt: json['frstRegtDt'] == null
          ? null
          : DateTime.parse(json['frstRegtDt'] as String),
      finlUpdtDt: json['finlUpdtDt'] == null
          ? null
          : DateTime.parse(json['finlUpdtDt'] as String),
    );

Map<String, dynamic> _$PwdChgHistModelToJson(PwdChgHistModel instance) =>
    <String, dynamic>{
      'membNo': instance.membNo,
      'applStrtDay': instance.applStrtDay,
      'pwd': instance.pwd,
      'applEndDay': instance.applEndDay,
      'delYn': instance.delYn,
      'frstRegtDt': instance.frstRegtDt?.toIso8601String(),
      'finlUpdtDt': instance.finlUpdtDt?.toIso8601String(),
    };
