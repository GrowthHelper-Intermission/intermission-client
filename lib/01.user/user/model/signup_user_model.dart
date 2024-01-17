import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_user_model.g.dart';


@JsonSerializable()
class SignupUserModel extends UserModelBase {
  final String? email;
  final String? password;
  final String? isTermsAgreed;
  final String? isPrivacyAgreed;

  final String? jobCd;
  final String? asignJobCd;
  final String? wedCd;
  final String? genderCd;
  final String? occpSidoCd;
  final String? occpSigunguCd;
  final String? houseTpCd;
  final String? petCd;
  final String? userCd;

  final String? birthday;
  final String? uniqueKey;
  final String? certifiedAt;
  final String? phoneNumber;
  final String? userName;

  /// 회원가입시 중복 API 요청 방지용 isSignup
  final bool? isSignup;

  SignupUserModel({
    this.email,
    this.password,
    this.isTermsAgreed,
    this.isPrivacyAgreed,
    this.jobCd,///학생/직업
    this.asignJobCd, ///jobCd == 직장인 일때
    this.wedCd, ///결혼
    this.genderCd, ///성별
    this.occpSidoCd, ///시, 도
    this.occpSigunguCd,///시군구
    this.houseTpCd, ///거주형태
    this.petCd, ///애완동물
    this.userCd, ///개인/공공기관/기업
    this.birthday,
    this.uniqueKey,
    this.certifiedAt,
    this.phoneNumber,
    this.userName,
    this.isSignup,
  });


  factory SignupUserModel.fromJson(Map<String, dynamic> json) =>
      _$SignupUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupUserModelToJson(this);
}
