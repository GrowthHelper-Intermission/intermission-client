// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBankModel _$UserBankModelFromJson(Map<String, dynamic> json) =>
    UserBankModel(
      bank: json['bank'] as String,
      accountNumber: json['accountNumber'] as String,
    );

Map<String, dynamic> _$UserBankModelToJson(UserBankModel instance) =>
    <String, dynamic>{
      'bank': instance.bank,
      'accountNumber': instance.accountNumber,
    };
