// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResearchDetailModel _$ResearchDetailModelFromJson(Map<String, dynamic> json) =>
    ResearchDetailModel(
      id: json['id'] as int,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      dueDate: json['dueDate'] as String,
      exceptTime: json['exceptTime'] as String,
      researchMethTpCd: json['researchMethTpCd'] as String,
      researchRewdPoint: json['researchRewdPoint'] as String,
      isEligible: json['isEligible'] as String,
      researchUrl: json['researchUrl'] as String,
      detail: json['detail'] as String,
      researchType: json['researchType'] as String,
      minAge: json['minAge'] as String,
      researchCurrentCnt: json['researchCurrentCnt'] as int,
      researchTargetCnt: json['researchTargetCnt'] as int,
      isScrap: json['isScrap'] as String,
      scrapCnt: json['scrapCnt'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'researchRewdPoint': instance.researchRewdPoint,
      'isEligible': instance.isEligible,
      'researchType': instance.researchType,
      'minAge': instance.minAge,
      'detail': instance.detail,
      'researchTargetCnt': instance.researchTargetCnt,
      'researchCurrentCnt': instance.researchCurrentCnt,
      'isScrap': instance.isScrap,
      'scrapCnt': instance.scrapCnt,
      'comments': instance.comments,
      'researchUrl': instance.researchUrl,
    };
