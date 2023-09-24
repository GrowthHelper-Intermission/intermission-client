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
  // 변수들
  final int? userId;
  final String? userTpCd;
  final String? userNm;
  final String? joinDay;
  final String? bankAccount;
  final String? accountNumber;
  final String? birthDay;
  final String? genderCd;
  final String? hpNum;
  final String? email;
  final String? jobCd;
  final String? jobGrdNm;
  final String? asignJobCd;
  final String? wedTpCd;
  final String? housTpCd;
  final String? petYn;
  final String? petTpCd;
  final String? petNm;
  final String? occpSidoCd;
  final String? occpSigunguCd;
  final String? researchSidoCd;
  final String? researchSigunguCd;
  final String? oflResRwdTpCd;
  final String? onlResRwdTpCd;
  final String? mainUseOnlSvcCn;
  final String? hobySubs;
  final String? rcmdUserCd;
  final String? isAgreeYn;
  final String? delYn;
  final String? pointAmt;

  UserModel({
    this.userId,
    this.userTpCd,
    this.userNm,
    this.joinDay,
    this.bankAccount,
    this.accountNumber,
    this.birthDay,
    this.genderCd,
    this.hpNum,
    this.email,
    this.jobCd,
    this.asignJobCd,
    this.jobGrdNm,
    this.wedTpCd,
    this.housTpCd,
    this.petYn,
    this.petTpCd,
    this.petNm,
    this.occpSidoCd,
    this.occpSigunguCd,
    this.researchSidoCd,
    this.researchSigunguCd,
    this.oflResRwdTpCd,
    this.onlResRwdTpCd,
    this.mainUseOnlSvcCn,
    this.hobySubs,
    this.rcmdUserCd,
    this.isAgreeYn,
    this.delYn,
    this.pointAmt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json)
  => _$UserModelFromJson(json);

  Map<String,dynamic> toJson() => _$UserModelToJson(this);
}
