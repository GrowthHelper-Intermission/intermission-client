// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupUserModel _$SignupUserModelFromJson(Map<String, dynamic> json) =>
    SignupUserModel(
      taskCd: json['taskCd'] as String?,
      industryCd: json['industryCd'] as String?,
      industryDetailCd: json['industryDetailCd'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      isTermsAgreed: json['isTermsAgreed'] as String?,
      isPrivacyAgreed: json['isPrivacyAgreed'] as String?,
      jobCd: json['jobCd'] as String?,
      wedCd: json['wedCd'] as String?,
      genderCd: json['genderCd'] as String?,
      occpSidoCd: json['occpSidoCd'] as String?,
      occpSigunguCd: json['occpSigunguCd'] as String?,
      houseTpCd: json['houseTpCd'] as String?,
      birthday: json['birthday'] as String?,
      uniqueKey: json['uniqueKey'] as String?,
      certifiedAt: json['certifiedAt'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userName: json['userName'] as String?,
      isSignup: json['isSignup'] as bool?,
    );

Map<String, dynamic> _$SignupUserModelToJson(SignupUserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'isTermsAgreed': instance.isTermsAgreed,
      'isPrivacyAgreed': instance.isPrivacyAgreed,
      'jobCd': instance.jobCd,
      'taskCd': instance.taskCd,
      'industryCd': instance.industryCd,
      'industryDetailCd': instance.industryDetailCd,
      'wedCd': instance.wedCd,
      'genderCd': instance.genderCd,
      'occpSidoCd': instance.occpSidoCd,
      'occpSigunguCd': instance.occpSigunguCd,
      'houseTpCd': instance.houseTpCd,
      'birthday': instance.birthday,
      'uniqueKey': instance.uniqueKey,
      'certifiedAt': instance.certifiedAt,
      'phoneNumber': instance.phoneNumber,
      'userName': instance.userName,
      'isSignup': instance.isSignup,
    };
