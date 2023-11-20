// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      id: json['id'] as String,
      mainTitle: json['mainTitle'] as String,
      postDate: json['postDate'] as String?,
      isAnswer: json['isAnswer'] as String,
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'postDate': instance.postDate,
      'isAnswer': instance.isAnswer,
    };
