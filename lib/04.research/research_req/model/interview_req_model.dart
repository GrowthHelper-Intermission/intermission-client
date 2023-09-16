import 'package:json_annotation/json_annotation.dart';

part 'interview_req_model.g.dart';

@JsonSerializable()
class InterviewReqModel {
  final String taskTpCd; // 대표자
  final String compNm; // 카카오
  final String itemOneLine; // 아이템 한줄 소개
  final String researchMethTpCd; // 오프라인, 서울 중구
  final String exceptTime; // 80
  final String researchRewdAmt; // 40000
  final String whatYouWant; // 원하는 특성을 적어라 시발아
  final String researchEntryCnt; // 10
  final String etcReqCn; // 추가요구사항
  final String matching; // "Y"
  final String question; // "Y"
  final String instead; // "Y"
  final String questionDetail; // 질문개발및대행시, 인터뷰 목적을 상세히
  final String isAgree; // "Y"

  InterviewReqModel({
    required this.taskTpCd,
    required this.compNm,
    required this.itemOneLine,
    required this.researchMethTpCd,
    required this.exceptTime,
    required this.researchRewdAmt,
    required this.whatYouWant,
    required this.researchEntryCnt,
    required this.etcReqCn,
    required this.matching,
    required this.question,
    required this.instead,
    required this.questionDetail,
    required this.isAgree,
  });

  factory InterviewReqModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewReqModelToJson(this);
}
