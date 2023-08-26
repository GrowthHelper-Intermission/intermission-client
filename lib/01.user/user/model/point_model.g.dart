// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointModel _$PointModelFromJson(Map<String, dynamic> json) => PointModel(
      userPoint: json['userPoint'] as int?,
      userId: json['userId'] as String?,
      pointDate: json['pointDate'] as String?,
      researchId: json['researchId'] as String?,
    );

Map<String, dynamic> _$PointModelToJson(PointModel instance) =>
    <String, dynamic>{
      'userPoint': instance.userPoint,
      'userId': instance.userId,
      'pointDate': instance.pointDate,
      'researchId': instance.researchId,
    };
