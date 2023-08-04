// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointModel _$PointModelFromJson(Map<String, dynamic> json) => PointModel(
      membNo: json['membNo'] as String,
      pontOccrDay: json['pontOccrDay'] as String,
      pontOccrSeqNo: json['pontOccrSeqNo'] as String,
      accuUseTpCd: json['accuUseTpCd'] as String,
      pontAmt: json['pontAmt'] as int,
      joinReqDay: json['joinReqDay'] as String,
      joinReqSeqNo: json['joinReqSeqNo'] as String,
      delYn: json['delYn'] as String,
      frstRegtDt: DateTime.parse(json['frstRegtDt'] as String),
      finlUpdtDt: DateTime.parse(json['finlUpdtDt'] as String),
    );

Map<String, dynamic> _$PointModelToJson(PointModel instance) =>
    <String, dynamic>{
      'membNo': instance.membNo,
      'pontOccrDay': instance.pontOccrDay,
      'pontOccrSeqNo': instance.pontOccrSeqNo,
      'accuUseTpCd': instance.accuUseTpCd,
      'pontAmt': instance.pontAmt,
      'joinReqDay': instance.joinReqDay,
      'joinReqSeqNo': instance.joinReqSeqNo,
      'delYn': instance.delYn,
      'frstRegtDt': instance.frstRegtDt.toIso8601String(),
      'finlUpdtDt': instance.finlUpdtDt.toIso8601String(),
    };
