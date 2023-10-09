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
      successUrl: json['success_url'] as String?,
      failUrl: json['fail_url'] as String?,
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
      minAge: json['min_age'] as int?,
      popup: json['popup'] as bool?,
      mRedirectUrl: json['m_redirect_url'] as String?,
      merchantUid: json['merchant_uid'] as String?,
    );

Map<String, dynamic> _$CertificationDataToJson(CertificationData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pg', instance.pg);
  writeNotNull('merchant_uid', instance.merchantUid);
  writeNotNull('mid', instance.mid);
  writeNotNull('reqSvcCd', instance.reqSvcCd);
  writeNotNull('mTxId', instance.mTxId);
  writeNotNull('success_url', instance.successUrl);
  writeNotNull('fail_url', instance.failUrl);
  writeNotNull('authHash', instance.authHash);
  writeNotNull('flgFixedUser', instance.flgFixedUser);
  writeNotNull('userName', instance.userName);
  writeNotNull('userPhone', instance.userPhone);
  writeNotNull('userBirth', instance.userBirth);
  writeNotNull('company', instance.company);
  writeNotNull('carrier', instance.carrier);
  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('reversedMsg', instance.reversedMsg);
  writeNotNull('userHash', instance.userHash);
  writeNotNull('directAgency', instance.directAgency);
  writeNotNull('min_age', instance.minAge);
  writeNotNull('popup', instance.popup);
  writeNotNull('m_redirect_url', instance.mRedirectUrl);
  return val;
}
