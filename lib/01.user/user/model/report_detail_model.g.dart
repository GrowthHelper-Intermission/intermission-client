// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDetailModel _$ReportDetailModelFromJson(Map<String, dynamic> json) =>
    ReportDetailModel(
      id: json['id'] as String,
      mainTitle: json['mainTitle'] as String,
      postDate: json['postDate'] as String,
      isAnswer: json['isAnswer'] as String,
      detail: json['detail'] as String,
    );

Map<String, dynamic> _$ReportDetailModelToJson(ReportDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainTitle': instance.mainTitle,
      'postDate': instance.postDate,
      'isAnswer': instance.isAnswer,
      'detail': instance.detail,
    };
