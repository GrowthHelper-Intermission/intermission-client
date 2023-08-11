// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewDetailModel _$InterviewDetailModelFromJson(
        Map<String, dynamic> json) =>
    InterviewDetailModel(
      id: json['id'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      isOnline: $enumDecode(_$onlineCategoryEnumMap, json['isOnline']),
      hourlyRate: json['hourlyRate'] as String,
      dueDate: json['dueDate'] as String,
      isOnGoing: json['isOnGoing'] as String,
      detail: json['detail'] as String,
    );

Map<String, dynamic> _$InterviewDetailModelToJson(
        InterviewDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'isOnline': _$onlineCategoryEnumMap[instance.isOnline]!,
      'hourlyRate': instance.hourlyRate,
      'dueDate': instance.dueDate,
      'isOnGoing': instance.isOnGoing,
      'detail': instance.detail,
    };

const _$onlineCategoryEnumMap = {
  onlineCategory.online: 'online',
  onlineCategory.offline: 'offline',
  onlineCategory.both: 'both',
};
