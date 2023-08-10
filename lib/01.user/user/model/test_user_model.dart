import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_user_model.g.dart';

@JsonSerializable()
class TestUserModel extends UserModelBase {
  final String? id;
  final String emailAccount;
  final String password;
  final String name;
  final String? gender;
  final String? phoneNumber;
  final int age;
  final bool? isMarried;
  final String? residenceType;
  final bool? isRaisePet;
  final String? kindOfPet;
  final String? residenceArea;
  final String? interviewPossibleArea;
  final String? interviewReward;
  final String? oftenUsingService;
  final String? hobby;
  final String? recommendWho;
  final int userPoint;
  final bool? isAgree;
  final String? userBankAccount;
  final String? accountNumber;
  final String? createdTime;
  final int recommendSum;
  final bool? emailVerified;
  final String? verificationCode;

  TestUserModel({
    this.id,
    required this.emailAccount,
    required this.password,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.age,
    required this.isMarried,
    required this.residenceType,
    required this.isRaisePet,
    this.kindOfPet,
    this.residenceArea,
    this.interviewPossibleArea,
    this.interviewReward,
    this.oftenUsingService,
    this.hobby,
    this.recommendWho,
    required this.userPoint,
    this.isAgree,
    this.userBankAccount,
    this.accountNumber,
    this.createdTime,
    required this.recommendSum,
    this.emailVerified,
    this.verificationCode,
  });

  factory TestUserModel.fromJson(Map<String, dynamic> json) =>
      _$TestUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$TestUserModelToJson(this);
}
