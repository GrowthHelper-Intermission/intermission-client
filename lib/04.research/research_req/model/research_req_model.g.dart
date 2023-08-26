// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResearchReqModel _$ResearchReqModelFromJson(Map<String, dynamic> json) =>
    ResearchReqModel(
      userId: json['userId'] as String?,
      taskTpCd: json['taskTpCd'] as String?,
      etcTaskSubs: json['etcTaskSubs'] as String?,
      compNm: json['compNm'] as String?,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      researchMethTpCd: json['researchMethTpCd'] as String,
      researchRewdAmt: json['researchRewdAmt'] as String?,
      dueDate: json['dueDate'] as String,
      exceptTime: json['exceptTime'] as String,
      minAge: json['minAge'] as String,
      detail: json['detail'] as String,
      researchType: json['researchType'] as String,
      researchTgtZendTpCd: json['researchTgtZendTpCd'] as String?,
      researchEntryCnt: json['researchEntryCnt'] as String?,
      etcReqCn: json['etcReqCn'] as String?,
      researchPostAgreeYn: json['researchPostAgreeYn'] as String?,
      hpNum: json['hpNum'] as String?,
      email: json['email'] as String?,
      delYn: json['delYn'] as String?,
    );

Map<String, dynamic> _$ResearchReqModelToJson(ResearchReqModel instance) =>
    <String, dynamic>{
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'dueDate': instance.dueDate,
      'exceptTime': instance.exceptTime,
      'minAge': instance.minAge,
      'detail': instance.detail,
      'researchType': instance.researchType,
      'researchMethTpCd': instance.researchMethTpCd,
      'researchRewdAmt': instance.researchRewdAmt,
      'userId': instance.userId,
      'email': instance.email,
      'taskTpCd': instance.taskTpCd,
      'etcTaskSubs': instance.etcTaskSubs,
      'compNm': instance.compNm,
      'researchTgtZendTpCd': instance.researchTgtZendTpCd,
      'researchEntryCnt': instance.researchEntryCnt,
      'etcReqCn': instance.etcReqCn,
      'researchPostAgreeYn': instance.researchPostAgreeYn,
      'hpNum': instance.hpNum,
      'delYn': instance.delYn,
    };
