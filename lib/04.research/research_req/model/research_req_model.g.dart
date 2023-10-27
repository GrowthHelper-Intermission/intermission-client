// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResearchReqModel _$ResearchReqModelFromJson(Map<String, dynamic> json) =>
    ResearchReqModel(
      researchUrl: json['researchUrl'] as String?,
      researchRewdPoint: json['researchRewdPoint'] as int?,
      researchTgtAsignTpCd: json['researchTgtAsignTpCd'] as String?,
      researchTgtHouseTpCd: json['researchTgtHouseTpCd'] as String?,
      researchTgtJobTpCd: json['researchTgtJobTpCd'] as String?,
      researchTgtWedTpCd: json['researchTgtWedTpCd'] as String?,
      taskTpCd: json['taskTpCd'] as String?,
      etcTaskSubs: json['etcTaskSubs'] as String?,
      compNm: json['compNm'] as String?,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      researchMethTpCd: json['researchMethTpCd'] as String,
      researchRewdAmt: json['researchRewdAmt'] as String?,
      dueDate: json['dueDate'] as String,
      exceptTime: json['exceptTime'] as String,
      isTeenagers: json['isTeenagers'] as String?,
      isTwenties: json['isTwenties'] as String?,
      isThirties: json['isThirties'] as String?,
      isForties: json['isForties'] as String?,
      isFifties: json['isFifties'] as String?,
      isSixties: json['isSixties'] as String?,
      isSeventies: json['isSeventies'] as String?,
      detail: json['detail'] as String,
      researchType: json['researchType'] as String,
      researchTgtZendTpCd: json['researchTgtZendTpCd'] as String?,
      researchEntryCnt: json['researchEntryCnt'] as String?,
      etcReqCn: json['etcReqCn'] as String?,
      researchPostAgreeYn: json['researchPostAgreeYn'] as String?,
      hpNum: json['hpNum'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ResearchReqModelToJson(ResearchReqModel instance) =>
    <String, dynamic>{
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'dueDate': instance.dueDate,
      'exceptTime': instance.exceptTime,
      'isTeenagers': instance.isTeenagers,
      'isTwenties': instance.isTwenties,
      'isThirties': instance.isThirties,
      'isForties': instance.isForties,
      'isFifties': instance.isFifties,
      'isSixties': instance.isSixties,
      'isSeventies': instance.isSeventies,
      'detail': instance.detail,
      'researchType': instance.researchType,
      'researchMethTpCd': instance.researchMethTpCd,
      'researchRewdAmt': instance.researchRewdAmt,
      'email': instance.email,
      'taskTpCd': instance.taskTpCd,
      'etcTaskSubs': instance.etcTaskSubs,
      'compNm': instance.compNm,
      'researchTgtZendTpCd': instance.researchTgtZendTpCd,
      'researchEntryCnt': instance.researchEntryCnt,
      'etcReqCn': instance.etcReqCn,
      'researchPostAgreeYn': instance.researchPostAgreeYn,
      'hpNum': instance.hpNum,
      'researchTgtAsignTpCd': instance.researchTgtAsignTpCd,
      'researchTgtHouseTpCd': instance.researchTgtHouseTpCd,
      'researchTgtJobTpCd': instance.researchTgtJobTpCd,
      'researchTgtWedTpCd': instance.researchTgtWedTpCd,
      'researchRewdPoint': instance.researchRewdPoint,
      'researchUrl': instance.researchUrl,
    };
