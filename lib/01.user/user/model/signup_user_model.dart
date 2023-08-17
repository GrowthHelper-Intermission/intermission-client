import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_user_model.g.dart';


@JsonSerializable()
class SignupUserModel extends UserModelBase {
  final String? userTpCd;
  final String? userNm;
  final String? userId;
  final String? pwd;
  final String? bankAccount;
  final String? accountNumber;
  final String? birthDay;
  final String? genderCd;
  final String? hpNum;
  final String? email;
  final String? emailVerfYn;
  final String? jobCd;
  final String? asignJobCd;
  final String? jobGrdNm;
  final String? wedTpCd;
  final String? housTpCd;
  final String? petYn;
  final String? petTpCd;
  final String? petNm;
  final String? occpSidoCd;
  final String? occpSigunguCd;
  final String? intvSidoCd;
  final String? intvSigunguCd;
  final String? oflIntvRwdTpCd;
  final String? onlIntvRwdTpCd;
  final String? mainUseOnlSvcCn;
  final String? hobySubs;
  final String? rcmdUserCd;
  final String? isAgreeYn;
  final String? isAgreeDt;
  final String? empYn;
  final String? empNo;
  final String? delYn;

  SignupUserModel({
    this.userTpCd,
    this.userNm,
    this.userId,
    this.pwd,
    this.bankAccount,
    this.accountNumber,
    this.birthDay,
    this.genderCd,
    this.hpNum,
    this.email,
    this.emailVerfYn,
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
    this.intvSidoCd,
    this.intvSigunguCd,
    this.oflIntvRwdTpCd,
    this.onlIntvRwdTpCd,
    this.mainUseOnlSvcCn,
    this.hobySubs,
    this.rcmdUserCd,
    this.isAgreeYn,
    this.isAgreeDt,
    this.empYn,
    this.empNo,
    this.delYn,
  });

  factory SignupUserModel.fromJson(Map<String, dynamic> json) =>
      _$SignupUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupUserModelToJson(this);
}
