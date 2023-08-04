// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noti_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotiModel _$NotiModelFromJson(Map<String, dynamic> json) => NotiModel(
      notiNo: json['notiNo'] as int,
      notiSubs: json['notiSubs'] as String?,
      postEmpNo: json['postEmpNo'] as String?,
      prodNo: json['prodNo'] as String?,
      reqDay: json['reqDay'] as String?,
      reqSeqNo: json['reqSeqNo'] as String?,
      frstRegtDt: json['frstRegtDt'] == null
          ? null
          : DateTime.parse(json['frstRegtDt'] as String),
      frstRegtEmpNo: json['frstRegtEmpNo'] as String?,
      finlUpdtDt: json['finlUpdtDt'] == null
          ? null
          : DateTime.parse(json['finlUpdtDt'] as String),
      finlUpdtEmpNo: json['finlUpdtEmpNo'] as String?,
    );

Map<String, dynamic> _$NotiModelToJson(NotiModel instance) => <String, dynamic>{
      'notiNo': instance.notiNo,
      'notiSubs': instance.notiSubs,
      'postEmpNo': instance.postEmpNo,
      'prodNo': instance.prodNo,
      'reqDay': instance.reqDay,
      'reqSeqNo': instance.reqSeqNo,
      'frstRegtDt': instance.frstRegtDt?.toIso8601String(),
      'frstRegtEmpNo': instance.frstRegtEmpNo,
      'finlUpdtDt': instance.finlUpdtDt?.toIso8601String(),
      'finlUpdtEmpNo': instance.finlUpdtEmpNo,
    };
