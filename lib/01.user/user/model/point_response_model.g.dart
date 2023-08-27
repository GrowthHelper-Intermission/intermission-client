// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointResponse _$PointResponseFromJson(Map<String, dynamic> json) =>
    PointResponse(
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => PointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PointResponseToJson(PointResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      count: json['count'] as int,
      hasMore: json['hasMore'] as bool,
      totalPoint: json['totalPoint'] as int,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'count': instance.count,
      'hasMore': instance.hasMore,
      'totalPoint': instance.totalPoint,
    };
