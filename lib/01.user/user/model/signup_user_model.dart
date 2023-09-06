import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_user_model.g.dart';


@JsonSerializable()
class SignupUserModel extends UserModelBase {
  final String? userTpCd;
  final String? userNm;
  final String? pwd;
  final String? bankAccount;
  final String? accountNumber;
  final String? birthDay;
  final String? genderCd;
  final String? hpNum;
  final String? email;
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
  final String? researchSidoCd;
  final String? researchSigunguCd;
  final String? oflResRwdTpCd;
  final String? onlResRwdTpCd;
  final String? mainUseOnlSvcCn;
  final String? hobySubs;
  final String? isAgreeYn;
  final String? delYn;

  SignupUserModel({
    this.userTpCd,
    this.userNm,
    // this.userId,
    this.pwd,
    this.bankAccount,
    this.accountNumber,
    this.birthDay,
    this.genderCd,
    this.hpNum,
    this.email,
    // this.emailVerfYn,
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
    this.isAgreeYn,
    // this.isAgreeDt,
    // this.empYn,
    // this.empNo,
    this.delYn,
  });

  factory SignupUserModel.fromJson(Map<String, dynamic> json) =>
      _$SignupUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupUserModelToJson(this);
}
