// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userTpCd: json['userTpCd'] as String?,
      joinDay: json['joinDay'] as String?,
      userName: json['userName'] as String?,
      bank: json['bank'] as String?,
      accountNumber: json['accountNumber'] as String?,
      birthday: json['birthday'] as String?,
      genderCd: json['genderCd'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      jobCd: json['jobCd'] as String?,
      asignJobCd: json['asignJobCd'] as String?,
      wedCd: json['wedCd'] as String?,
      housTpCd: json['housTpCd'] as String?,
      petCd: json['petCd'] as String?,
      address: json['address'] as String?,
      referralCode: json['referralCode'] as String?,
      isTermsAgreed: json['isTermsAgreed'] as String?,
      isPrivacyAgreed: json['isPrivacyAgreed'] as String?,
      pointAmount: json['pointAmount'] as String?,
      friendCount: json['friendCount'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userTpCd': instance.userTpCd,
      'joinDay': instance.joinDay,
      'userName': instance.userName,
      'bank': instance.bank,
      'accountNumber': instance.accountNumber,
      'birthday': instance.birthday,
      'genderCd': instance.genderCd,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'jobCd': instance.jobCd,
      'asignJobCd': instance.asignJobCd,
      'wedCd': instance.wedCd,
      'housTpCd': instance.housTpCd,
      'petCd': instance.petCd,
      'address': instance.address,
      'referralCode': instance.referralCode,
      'isTermsAgreed': instance.isTermsAgreed,
      'isPrivacyAgreed': instance.isPrivacyAgreed,
      'pointAmount': instance.pointAmount,
      'friendCount': instance.friendCount,
    };
