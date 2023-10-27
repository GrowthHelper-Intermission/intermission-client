// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestUserModel _$TestUserModelFromJson(Map<String, dynamic> json) =>
    TestUserModel(
      id: json['id'] as String?,
      emailAccount: json['emailAccount'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      age: json['age'] as int,
      isMarried: json['isMarried'] as bool?,
      residenceType: json['residenceType'] as String?,
      isRaisePet: json['isRaisePet'] as bool?,
      kindOfPet: json['kindOfPet'] as String?,
      residenceArea: json['residenceArea'] as String?,
      interviewPossibleArea: json['interviewPossibleArea'] as String?,
      interviewReward: json['interviewReward'] as String?,
      oftenUsingService: json['oftenUsingService'] as String?,
      hobby: json['hobby'] as String?,
      recommendWho: json['recommendWho'] as String?,
      userPoint: json['userPoint'] as int,
      isAgree: json['isAgree'] as bool?,
      userBankAccount: json['userBankAccount'] as String?,
      accountNumber: json['accountNumber'] as String?,
      createdTime: json['createdTime'] as String?,
      recommendSum: json['recommendSum'] as int,
      emailVerified: json['emailVerified'] as bool?,
      verificationCode: json['verificationCode'] as String?,
    );

Map<String, dynamic> _$TestUserModelToJson(TestUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'emailAccount': instance.emailAccount,
      'password': instance.password,
      'name': instance.name,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'age': instance.age,
      'isMarried': instance.isMarried,
      'residenceType': instance.residenceType,
      'isRaisePet': instance.isRaisePet,
      'kindOfPet': instance.kindOfPet,
      'residenceArea': instance.residenceArea,
      'interviewPossibleArea': instance.interviewPossibleArea,
      'interviewReward': instance.interviewReward,
      'oftenUsingService': instance.oftenUsingService,
      'hobby': instance.hobby,
      'recommendWho': instance.recommendWho,
      'userPoint': instance.userPoint,
      'isAgree': instance.isAgree,
      'userBankAccount': instance.userBankAccount,
      'accountNumber': instance.accountNumber,
      'createdTime': instance.createdTime,
      'recommendSum': instance.recommendSum,
      'emailVerified': instance.emailVerified,
      'verificationCode': instance.verificationCode,
    };
