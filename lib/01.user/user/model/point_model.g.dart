// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointModel _$PointModelFromJson(Map<String, dynamic> json) => PointModel(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      expireTime: json['expireTime'] as String,
      pointStatus: json['pointStatus'] as String,
      pointAmount: json['pointAmount'] as int,
      researchTitle: json['researchTitle'] as String,
      researchType: json['researchType'] as String,
    );

Map<String, dynamic> _$PointModelToJson(PointModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'expireTime': instance.expireTime,
      'pointStatus': instance.pointStatus,
      'pointAmount': instance.pointAmount,
      'researchTitle': instance.researchTitle,
      'researchType': instance.researchType,
    };
