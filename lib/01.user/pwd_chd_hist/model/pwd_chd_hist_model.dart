import 'package:json_annotation/json_annotation.dart';

part 'pwd_chd_hist_model.g.dart';

@JsonSerializable()
class PwdChgHistModel {
  /// 회원번호
  final String membNo;

  /// 적용시작일자
  final String applStrtDay;

  /// 비밀번호
  final String pwd;

  /// 적용종료일자
  final String? applEndDay;

  /// 삭제여부
  final String? delYn;

  /// 최초입력일시
  final DateTime? frstRegtDt;

  /// 최종수정일시
  final DateTime? finlUpdtDt;

  PwdChgHistModel({
    required this.membNo,
    required this.applStrtDay,
    required this.pwd,
    this.applEndDay,
    this.delYn,
    this.frstRegtDt,
    this.finlUpdtDt,
  });

  factory PwdChgHistModel.fromJson(Map<String, dynamic> json)
  => _$PwdChgHistModelFromJson(json);
  Map<String,dynamic> toJson() => _$PwdChgHistModelToJson(this);

}