
import 'package:json_annotation/json_annotation.dart';

part 'change_bank_model.g.dart';

@JsonSerializable()
class ChangeBankModel {
  final String? bank;
  final String? bankAccount;

  ChangeBankModel({this.bank, this.bankAccount});

  factory ChangeBankModel.fromJson(Map<String, dynamic> json)
  => _$ChangeBankModelFromJson(json);

  Map<String,dynamic> toJson() => _$ChangeBankModelToJson(this);
}
