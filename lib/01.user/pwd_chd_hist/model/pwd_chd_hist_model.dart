import 'package:json_annotation/json_annotation.dart';

part 'pwd_chd_hist_model.g.dart';

@JsonSerializable()
class PwdChgHistModel {
  /// 회원번호(PK,FK)
  final String membNo;

  /// 적용시작일자(PK)
  final String applStrtDay;

  /// 비밀번호(새로 변경된 비밀번호, 회원 테이블의 비밀번호 항목에 Update 시켜야함)
  final String pwd;

  /// 적용종료일자
  //(구 비밀번호와 신 비밀번호를 구분하기 위하여 생성,
  // 비밀번호가 변경되면 적용죵료일자에 SYSTEM DATE 입력, 신규 건은 99991231 입력)
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