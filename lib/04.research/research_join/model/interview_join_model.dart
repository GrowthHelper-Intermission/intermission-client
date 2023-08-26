import 'package:json_annotation/json_annotation.dart';
part 'interview_join_model.g.dart';

@JsonSerializable()
class InterviewJoinModel {
  /// 인터뷰 의뢰일자(PK,FK)
  final String intvReqDay;

  /// 인터뷰 의뢰 일련번호
  final String intvReqSeqNo;

  /// 참여 회원번호
  final String joinMembNo;

  /// 스크랩 여부
  final String? scrapYn;

  /// 인터뷰 여부
  final String? intvYn;

  /// 삭제 여부
  final String? delYn;

  /// 최초 입력일시
  final DateTime? frstRegtDt;

  /// 최종 수정일시
  final DateTime? finlUpdtDt;

  InterviewJoinModel({
    required this.intvReqDay,
    required this.intvReqSeqNo,
    required this.joinMembNo,
    this.scrapYn,
    this.intvYn,
    this.delYn,
    this.frstRegtDt,
    this.finlUpdtDt,
  });

  factory InterviewJoinModel.fromJson(Map<String, dynamic> json) => _$InterviewJoinModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewJoinModelToJson(this);
}
