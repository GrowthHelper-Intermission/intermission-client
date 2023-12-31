import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

class UserModelLoading extends UserModelBase {}

class UserModelSuccess extends UserModelBase {}

@JsonSerializable()
class UserModel extends UserModelBase {
  final String? userTpCd;
  final String? joinDay;
  final String? userName;
  final String? bank;
  final String? accountNumber;
  final String? birthday;
  final String? genderCd;
  final String? phoneNumber;
  final String? email;
  final String? jobCd;
  final String? asignJobCd;
  final String? wedCd;
  final String? housTpCd;
  final String? petCd;
  final String? address;
  final String? referralCode;
  final String? isTermsAgreed;
  final String? isPrivacyAgreed;
  final String? pointAmount;
  final String? friendCount;

  UserModel({
    this.userTpCd,
    this.joinDay,
    this.userName,
    this.bank,
    this.accountNumber,
    this.birthday,
    this.genderCd,
    this.phoneNumber,
    this.email,
    this.jobCd,
    this.asignJobCd,
    this.wedCd,
    this.housTpCd,
    this.petCd,
    this.address,
    this.referralCode,
    this.isTermsAgreed,
    this.isPrivacyAgreed,
    this.pointAmount,
    this.friendCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

