import 'package:json_annotation/json_annotation.dart';

part 'user_bank_model.g.dart';

@JsonSerializable()
class UserBankModel {
  final String bank;
  final String accountNumber;

  UserBankModel({
    required this.bank,
    required this.accountNumber,
  });

  factory UserBankModel.fromJson(Map<String, dynamic> json) =>
      _$UserBankModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserBankModelToJson(this);
}
