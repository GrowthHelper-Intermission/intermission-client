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

  SignupUserModel({
    this.email,
    this.password,
    this.isTermsAgreed,
    this.isPrivacyAgreed,
    this.jobCd,
    this.asignJobCd,
    this.wedCd,
    this.genderCd,
    this.occpSidoCd,
    this.occpSigunguCd,
    this.houseTpCd,
    this.petCd,
    this.userCd,
    this.birthday,
    this.uniqueKey,
    this.certifiedAt,
    this.phoneNumber,
    this.userName,
  });


  factory SignupUserModel.fromJson(Map<String, dynamic> json) =>
      _$SignupUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupUserModelToJson(this);
}
