// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewReqModel _$InterviewReqModelFromJson(Map<String, dynamic> json) =>
    InterviewReqModel(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      taskTpCd: json['taskTpCd'] as String?,
      etcTaskSubs: json['etcTaskSubs'] as String?,
      compNm: json['compNm'] as String?,
      itemNm: json['itemNm'] as String?,
      item1LnIntroCn: json['item1LnIntroCn'] as String?,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      intvMethTpCd: json['intvMethTpCd'] as String,
      intvRewdAmt: json['intvRewdAmt'] as String?,
      dueDate: json['dueDate'] as String,
      exceptTime: json['exceptTime'] as String,
      minAge: json['minAge'] as String,
      detail: json['detail'] as String,
      researchType: json['researchType'] as String,
      intvTgtZendTpCd: json['intvTgtZendTpCd'] as String?,
      intvTgtSubs: json['intvTgtSubs'] as String?,
      intvEntryCnt: json['intvEntryCnt'] as int?,
      etcReqCn: json['etcReqCn'] as String?,
      intvPostAgreeYn: json['intvPostAgreeYn'] as String?,
      hpNum: json['hpNum'] as String?,
      email: json['email'] as String?,
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
      'id': instance.id,
      'userId': instance.userId,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'intvMethTpCd': instance.intvMethTpCd,
      'intvRewdAmt': instance.intvRewdAmt,
      'dueDate': instance.dueDate,
      'exceptTime': instance.exceptTime,
      'minAge': instance.minAge,
      'detail': instance.detail,
      'researchType': instance.researchType,
      'taskTpCd': instance.taskTpCd,
      'etcTaskSubs': instance.etcTaskSubs,
      'compNm': instance.compNm,
      'itemNm': instance.itemNm,
      'item1LnIntroCn': instance.item1LnIntroCn,
      'intvTgtZendTpCd': instance.intvTgtZendTpCd,
      'intvTgtSubs': instance.intvTgtSubs,
      'intvEntryCnt': instance.intvEntryCnt,
      'etcReqCn': instance.etcReqCn,
      'intvPostAgreeYn': instance.intvPostAgreeYn,
      'hpNum': instance.hpNum,
      'email': instance.email,
      'delYn': instance.delYn,
      'frstRegtDt': instance.frstRegtDt?.toIso8601String(),
      'finlUpdtDt': instance.finlUpdtDt?.toIso8601String(),
    };
