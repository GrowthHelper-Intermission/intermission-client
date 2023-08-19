// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResearchModel _$ResearchModelFromJson(Map<String, dynamic> json) =>
    ResearchModel(
      id: json['id'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      dueDate: json['dueDate'] as String,
      isOnline: json['isOnline'] as String,
      hourlyRate: json['hourlyRate'] as String,
      isOnGoing: json['isOnGoing'] as String,
    );

Map<String, dynamic> _$ResearchModelToJson(ResearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'isOnline': instance.isOnline,
      'hourlyRate': instance.hourlyRate,
      'dueDate': instance.dueDate,
      'isOnGoing': instance.isOnGoing,
    };
