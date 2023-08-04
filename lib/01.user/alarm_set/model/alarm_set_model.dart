


import 'package:json_annotation/json_annotation.dart';

part 'alarm_set_model.g.dart';

@JsonSerializable()
class AlarmSetModel {
  /// 회원번호
  final String membNo;

  /// 알림구분코드
  final String notiTpCd;

  /// 적용시작일자
  final String applStrtDay;

  /// 적용종료일자
  final String? applEndDay;

  /// 삭제여부
  final String? delYn;

  /// 최초입력일시
  final DateTime? frstRegtDt;

  /// 최초입력사원번호
  final String? frstRegtEmpNo;

  /// 최종수정일시
  final DateTime? finlUpdtDt;

  /// 최종수정사원번호
  final String? finlUpdtEmpNo;

  AlarmSetModel({
    required this.membNo,
    required this.notiTpCd,
    required this.applStrtDay,
    this.applEndDay,
    this.delYn,
    this.frstRegtDt,
    this.frstRegtEmpNo,
    this.finlUpdtDt,
    this.finlUpdtEmpNo,
  });

  factory AlarmSetModel.fromJson(Map<String, dynamic> json)
  => _$AlarmSetModelFromJson(json);

  Map<String,dynamic> toJson() => _$AlarmSetModelToJson(this);
}
