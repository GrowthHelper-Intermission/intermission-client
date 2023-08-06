// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewModel _$InterviewModelFromJson(Map<String, dynamic> json) =>
    InterviewModel(
      id: json['id'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      dueDate: json['dueDate'] as String,
      isOnline: $enumDecode(_$onlineCategoryEnumMap, json['isOnline']),
      hourlyRate: json['hourlyRate'] as String,
      isOnGoing: json['isOnGoing'] as bool,
    );

Map<String, dynamic> _$InterviewModelToJson(InterviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'isOnline': _$onlineCategoryEnumMap[instance.isOnline]!,
      'hourlyRate': instance.hourlyRate,
      'dueDate': instance.dueDate,
      'isOnGoing': instance.isOnGoing,
    };

const _$onlineCategoryEnumMap = {
  onlineCategory.online: 'online',
  onlineCategory.offline: 'offline',
  onlineCategory.both: 'both',
};
