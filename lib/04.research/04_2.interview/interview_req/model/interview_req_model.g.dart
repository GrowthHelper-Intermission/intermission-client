// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewReqModel _$InterviewReqModelFromJson(Map<String, dynamic> json) =>
    InterviewReqModel(
      intvReqDay: json['intvReqDay'] as String,
      intvReqSeqNo: json['intvReqSeqNo'] as String,
      membNo: json['membNo'] as String?,
      prodNo: json['prodNo'] as String?,
      taskTpCd: json['taskTpCd'] as String?,
      etcTaskSubs: json['etcTaskSubs'] as String?,
      compNm: json['compNm'] as String?,
      itemNm: json['itemNm'] as String?,
      item1LnIntroCn: json['item1LnIntroCn'] as String?,
      intvNm: json['intvNm'] as String?,
      intvMethTpCd: json['intvMethTpCd'] as String?,
      expectTakeTm: json['expectTakeTm'] as int?,
      intvRewdAmt: json['intvRewdAmt'] as int?,
      intvTgtZendTpCd: json['intvTgtZendTpCd'] as String?,
      intvAge10Yn: json['intvAge10Yn'] as String?,
      intvAge20Yn: json['intvAge20Yn'] as String?,
      intvAge30Yn: json['intvAge30Yn'] as String?,
      intvAge40Yn: json['intvAge40Yn'] as String?,
      intvAge50Yn: json['intvAge50Yn'] as String?,
      intvAge60Yn: json['intvAge60Yn'] as String?,
      intvAge70Yn: json['intvAge70Yn'] as String?,
      intvAgeRandYn: json['intvAgeRandYn'] as String?,
      intvTgtSubs: json['intvTgtSubs'] as String?,
      intvEntryCnt: json['intvEntryCnt'] as int?,
      etcReqCn: json['etcReqCn'] as String?,
      intvPostAgreeYn: json['intvPostAgreeYn'] as String?,
      hpNum: json['hpNum'] as String?,
      email: json['email'] as String?,
      joinClosDay: json['joinClosDay'] as String?,
      delYn: json['delYn'] as String?,
      frstRegtDt: json['frstRegtDt'] == null
          ? null
          : DateTime.parse(json['frstRegtDt'] as String),
      finlUpdtDt: json['finlUpdtDt'] == null
          ? null
          : DateTime.parse(json['finlUpdtDt'] as String),
    );

Map<String, dynamic> _$InterviewReqModelToJson(InterviewReqModel instance) =>
    <String, dynamic>{
      'intvReqDay': instance.intvReqDay,
      'intvReqSeqNo': instance.intvReqSeqNo,
      'membNo': instance.membNo,
      'prodNo': instance.prodNo,
      'taskTpCd': instance.taskTpCd,
      'etcTaskSubs': instance.etcTaskSubs,
      'compNm': instance.compNm,
      'itemNm': instance.itemNm,
      'item1LnIntroCn': instance.item1LnIntroCn,
      'intvNm': instance.intvNm,
      'intvMethTpCd': instance.intvMethTpCd,
      'expectTakeTm': instance.expectTakeTm,
      'intvRewdAmt': instance.intvRewdAmt,
      'intvTgtZendTpCd': instance.intvTgtZendTpCd,
      'intvAge10Yn': instance.intvAge10Yn,
      'intvAge20Yn': instance.intvAge20Yn,
      'intvAge30Yn': instance.intvAge30Yn,
      'intvAge40Yn': instance.intvAge40Yn,
      'intvAge50Yn': instance.intvAge50Yn,
      'intvAge60Yn': instance.intvAge60Yn,
      'intvAge70Yn': instance.intvAge70Yn,
      'intvAgeRandYn': instance.intvAgeRandYn,
      'intvTgtSubs': instance.intvTgtSubs,
      'intvEntryCnt': instance.intvEntryCnt,
      'etcReqCn': instance.etcReqCn,
      'intvPostAgreeYn': instance.intvPostAgreeYn,
      'hpNum': instance.hpNum,
      'email': instance.email,
      'joinClosDay': instance.joinClosDay,
      'delYn': instance.delYn,
      'frstRegtDt': instance.frstRegtDt?.toIso8601String(),
      'finlUpdtDt': instance.finlUpdtDt?.toIso8601String(),
    };
