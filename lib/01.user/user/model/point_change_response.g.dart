// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_change_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointChangeResponse _$PointChangeResponseFromJson(Map<String, dynamic> json) =>
    PointChangeResponse(
      code: json['code'] as int,
      httpStatus: json['httpStatus'] as String?,
      message: json['message'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$PointChangeResponseToJson(
        PointChangeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'httpStatus': instance.httpStatus,
      'message': instance.message,
      'data': instance.data,
    };
