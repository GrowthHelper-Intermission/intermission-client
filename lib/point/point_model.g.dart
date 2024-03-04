// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointModel _$PointModelFromJson(Map<String, dynamic> json) => PointModel(
      id: json['id'] as int,
      pointStatus: json['pointStatus'] as String,
      pointChangeBalance: json['pointChangeBalance'] as int,
      pointCurrentBalance: json['pointCurrentBalance'] as int,
      pointPreviousBalance: json['pointPreviousBalance'] as int,
      pointEventType: json['pointEventType'] as String,
      createdDate: json['createdDate'] as String,
      expireTime: json['expireTime'] as String,
      pointEventName: json['pointEventName'] as String?,
    );

Map<String, dynamic> _$PointModelToJson(PointModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pointStatus': instance.pointStatus,
      'pointChangeBalance': instance.pointChangeBalance,
      'pointCurrentBalance': instance.pointCurrentBalance,
      'pointPreviousBalance': instance.pointPreviousBalance,
      'pointEventType': instance.pointEventType,
      'createdDate': instance.createdDate,
      'expireTime': instance.expireTime,
      'pointEventName': instance.pointEventName,
    };
