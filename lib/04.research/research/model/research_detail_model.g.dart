// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResearchDetailModel _$ResearchDetailModelFromJson(Map<String, dynamic> json) =>
    ResearchDetailModel(
      id: json['id'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      dueDate: json['dueDate'] as String,
      exceptTime: json['exceptTime'] as String,
      researchMethTpCd: json['researchMethTpCd'] as String,
      researchRewdAmt: json['researchRewdAmt'] as String,
      isOnGoing: json['isOnGoing'] as String,
      detail: json['detail'] as String,
      researchType: json['researchType'] as String,
      minAge: json['minAge'] as String,
      researchEntryCnt: json['researchEntryCnt'] as String,
      researchCnt: json['researchCnt'] as String,
      isJoin: json['isJoin'] as String,
    );

Map<String, dynamic> _$ResearchDetailModelToJson(
        ResearchDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'dueDate': instance.dueDate,
      'exceptTime': instance.exceptTime,
      'researchMethTpCd': instance.researchMethTpCd,
      'researchRewdAmt': instance.researchRewdAmt,
      'isOnGoing': instance.isOnGoing,
      'researchType': instance.researchType,
      'minAge': instance.minAge,
      'detail': instance.detail,
      'researchEntryCnt': instance.researchEntryCnt,
      'researchCnt': instance.researchCnt,
      'isJoin': instance.isJoin,
    };