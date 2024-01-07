// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrap_research_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScrapResearchModel _$ScrapResearchModelFromJson(Map<String, dynamic> json) =>
    ScrapResearchModel(
      scrapId: json['scrapId'] as String,
      id: json['id'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      dueDate: json['dueDate'] as String,
      exceptTime: json['exceptTime'] as String,
      researchMethTpCd: json['researchMethTpCd'] as String,
      researchRewdAmt: json['researchRewdAmt'] as String,
      isOnGoing: json['isOnGoing'] as String,
      isScreening: json['isScreening'] as String,
    );

Map<String, dynamic> _$ScrapResearchModelToJson(ScrapResearchModel instance) =>
    <String, dynamic>{
      'scrapId': instance.scrapId,
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'dueDate': instance.dueDate,
      'exceptTime': instance.exceptTime,
      'researchMethTpCd': instance.researchMethTpCd,
      'researchRewdAmt': instance.researchRewdAmt,
      'isOnGoing': instance.isOnGoing,
      'isScreening': instance.isScreening,
    };
