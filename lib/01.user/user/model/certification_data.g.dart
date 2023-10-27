// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationData _$CertificationDataFromJson(Map<String, dynamic> json) =>
    CertificationData(
      userHash: json['userHash'] as String?,
      directAgency: json['directAgency'] as String?,
      mid: json['mid'] as String?,
      reqSvcCd: json['reqSvcCd'] as String?,
      mTxId: json['mTxId'] as String?,
      successUrl: json['successUrl'] as String?,
      failUrl: json['failUrl'] as String?,
      authHash: json['authHash'] as String?,
      flgFixedUser: json['flgFixedUser'] as String?,
      userName: json['userName'] as String?,
      userPhone: json['userPhone'] as String?,
      userBirth: json['userBirth'] as String?,
      reversedMsg: json['reversedMsg'] as String?,
      pg: json['pg'] as String?,
      company: json['company'] as String?,
      carrier: json['carrier'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      minAge: json['minAge'] as int?,
      popup: json['popup'] as bool?,
      mRedirectUrl: json['mRedirectUrl'] as String?,
      merchantUid: json['merchant_uid'] as String?,
    );

Map<String, dynamic> _$CertificationDataToJson(CertificationData instance) =>
    <String, dynamic>{
      'pg': instance.pg,
      'merchant_uid': instance.merchantUid,
      'mid': instance.mid,
      'reqSvcCd': instance.reqSvcCd,
      'mTxId': instance.mTxId,
      'successUrl': instance.successUrl,
      'failUrl': instance.failUrl,
      'authHash': instance.authHash,
      'flgFixedUser': instance.flgFixedUser,
      'userName': instance.userName,
      'userPhone': instance.userPhone,
      'userBirth': instance.userBirth,
      'company': instance.company,
      'carrier': instance.carrier,
      'name': instance.name,
      'phone': instance.phone,
      'reversedMsg': instance.reversedMsg,
      'userHash': instance.userHash,
      'directAgency': instance.directAgency,
      'minAge': instance.minAge,
      'popup': instance.popup,
      'mRedirectUrl': instance.mRedirectUrl,
    };
