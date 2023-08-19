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
      isOnline: json['isOnline'] as String,
      hourlyRate: json['hourlyRate'] as String,
      dueDate: json['dueDate'] as String,
      isOnGoing: json['isOnGoing'] as String,
      detail: json['detail'] as String,
      researchType: json['researchType'] as String,
      exceptTime: json['exceptTime'] as String,
      minAge: json['minAge'] as String,
    );

Map<String, dynamic> _$ResearchDetailModelToJson(
        ResearchDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'isOnline': instance.isOnline,
      'hourlyRate': instance.hourlyRate,
      'dueDate': instance.dueDate,
      'isOnGoing': instance.isOnGoing,
      'detail': instance.detail,
      'researchType': instance.researchType,
      'exceptTime': instance.exceptTime,
      'minAge': instance.minAge,
    };
