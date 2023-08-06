import 'package:json_annotation/json_annotation.dart';

part 'alarm_set_model.g.dart';

@JsonSerializable()
class AlarmSetModel {
  /// 회원번호(10000000부터 시작, 자동증가, PK,FK)
  final String membNo;

  /// 알림구분코드(PK, 차후 enum변경)
  final String notiTpCd;

  /// 적용시작일자(해당 사항이 적용되기 시작한 일자)
  final String applStrtDay;

  /// 적용종료일자(변경 시 99991231 DEFAULT 입력되며, 이전 정보는 변경일자를 입)
  final String? applEndDay;

  /// 삭제여부
  final String? delYn;

  /// 최초입력일시
  final DateTime? frstRegtDt;

  // /// 최초입력사원번호(생략)
  // final String? frstRegtEmpNo;

  /// 최종수정일시
  final DateTime? finlUpdtDt;

  // /// 최종수정사원번호(생략)
  // final String? finlUpdtEmpNo;

  AlarmSetModel({
    required this.membNo,
    required this.notiTpCd,
    required this.applStrtDay,
    this.applEndDay,
    this.delYn,
    this.frstRegtDt,
    // this.frstRegtEmpNo,
    this.finlUpdtDt,
    // this.finlUpdtEmpNo,
  });

  factory AlarmSetModel.fromJson(Map<String, dynamic> json)
  => _$AlarmSetModelFromJson(json);

  Map<String,dynamic> toJson() => _$AlarmSetModelToJson(this);
}
