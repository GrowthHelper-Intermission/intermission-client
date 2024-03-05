// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResearchModel _$ResearchModelFromJson(Map<String, dynamic> json) =>
    ResearchModel(
      id: json['id'] as int,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      dueDate: json['dueDate'] as String,
      exceptTime: json['exceptTime'] as String,
      researchMethTpCd: json['researchMethTpCd'] as String,
      researchRewdPoint: json['researchRewdPoint'] as String,
      isEligible: json['isEligible'] as String,
    );

Map<String, dynamic> _$ResearchModelToJson(ResearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'dueDate': instance.dueDate,
      'exceptTime': instance.exceptTime,
      'researchMethTpCd': instance.researchMethTpCd,
      'researchRewdPoint': instance.researchRewdPoint,
      'isEligible': instance.isEligible,
    };
