import 'package:json_annotation/json_annotation.dart';

part 'certification_data.g.dart';

@JsonSerializable()
class CertificationData {
  String? pg;

  @JsonKey(name: 'merchant_uid')
  String? merchantUid;

  //커스텀 시작
  String? mid;
  String? reqSvcCd;
  String? mTxId;
  String? successUrl;
  String? failUrl;

  String? authHash;
  String? flgFixedUser;
  String? userName;
  String? userPhone;
  String? userBirth;

  String? company;
  String? carrier;
  String? name;
  String? phone;
  String? reversedMsg;

  String? userHash;
  String? directAgency;
  int? minAge;

  bool? popup;

  String? mRedirectUrl;

  CertificationData({
    this.userHash,
    this.directAgency,
    this.mid,
    this.reqSvcCd,
    this.mTxId,
    this.successUrl,
    this.failUrl,
    this.authHash,
    this.flgFixedUser,
    this.userName,
    this.userPhone,
    this.userBirth,
    this.reversedMsg,
    this.pg,
    this.company,
    this.carrier,
    this.name,
    this.phone,
    this.minAge,
    this.popup,
    this.mRedirectUrl,
    this.merchantUid,
  });

  factory CertificationData.fromJson(Map<String, dynamic> json) =>
      _$CertificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationDataToJson(this);
}
