import 'package:json_annotation/json_annotation.dart';
part 'point_model.g.dart';

@JsonSerializable()
class PointModel {
  /// 회원번호(PK, FK)
  final String membNo;

  /// 포인트발생일자(PK)
  final String pontOccrDay;

  /// 포인트발생일련번호(PK)
  final String pontOccrSeqNo;

  /// 적립사용구분코드
  final String accuUseTpCd; //  1(적립), 2(사용), 3(소멸), 9(기타)

  /// 포인트금액
  final int pontAmt;

  /// 참여의뢰일자
  final String joinReqDay;

  /// 참여의뢰일련번호
  final String joinReqSeqNo;

  /// 삭제여부
  final String delYn;

  /// 최초입력일시
  final DateTime frstRegtDt;

  /// 최종수정일시
  final DateTime finlUpdtDt;

  PointModel({
    required this.membNo,
    required this.pontOccrDay,
    required this.pontOccrSeqNo,
    required this.accuUseTpCd,
    required this.pontAmt,
    required this.joinReqDay,
    required this.joinReqSeqNo,
    required this.delYn,
    required this.frstRegtDt,
    required this.finlUpdtDt,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) => _$PointModelFromJson(json);

  Map<String, dynamic> toJson() => _$PointModelToJson(this);
}
