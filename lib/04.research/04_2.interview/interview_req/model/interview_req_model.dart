import 'package:json_annotation/json_annotation.dart';

part 'interview_req_model.g.dart';

@JsonSerializable()
class InterviewReqModel {
  /// 인터뷰의뢰일자(PK) 필수
  final String id;

  /// 회원번호(의뢰하는 userId) 필수
  final String? userId;

  /// 인터뷰명
  final String mainTitle;

  final String subTitle;

  final String intvMethTpCd;

  final String? intvRewdAmt;

  final String dueDate;

  final String exceptTime;

  final String minAge;

  final String detail;

  final String researchType;

  /// 직무유형코드(테스트후 변경예정 10,20,30,40,90,99)
  final String? taskTpCd;

  /// 기타직급내용(99일때만 입력하게끔)
  final String? etcTaskSubs;

  /// 회사명(회사명, 학교명, 단체명 등 소속 조직의 명칭)
  final String? compNm;

  /// 아이템명
  final String? itemNm;

  /// 아이템한줄소개내용
  final String? item1LnIntroCn;

  /// 인터뷰대상성별코드(M/F)
  final String? intvTgtZendTpCd;

  /// 인터뷰대상내용(인터뷰 세부 설명)
  final String? intvTgtSubs;

  /// 인터뷰대상인원수
  final int? intvEntryCnt;

  /// 기타요청사항내용(원하는 인터뷰 인원 특성, 조건기입하기)
  final String? etcReqCn;

  /// 인터뷰게시동의여부
  final String? intvPostAgreeYn;

  /// 선택적 기입(의뢰자가 기업소속이나, 다른 단체 휴대폰 있을때 위함)
  final String? hpNum;

  /// EMAIL주소(User정보에서 가져와야함. GET 요청 필수)
  final String? email;

  /// 삭제여부(물리적인 삭제는 없으며, Flag 처리)
  final String? delYn;

  /// 최초입력일시(데이터를 입력한 최초 일시 , SYSTEM DATE)
  final DateTime? frstRegtDt;

  /// 최종수정일시
  final DateTime? finlUpdtDt;

  // /// 인터뷰연령대10대여부(Y/N, Default = 'N')
  // final String? intvAge10Yn;
  //
  // /// 인터뷰연령대20대여부
  // final String? intvAge20Yn;
  //
  // /// 인터뷰연령대30대여부
  // final String? intvAge30Yn;
  //
  // /// 인터뷰연령대40대여부
  // final String? intvAge40Yn;
  //
  // /// 인터뷰연령대50대여부
  // final String? intvAge50Yn;
  //
  // /// 인터뷰연령대60대여부
  // final String? intvAge60Yn;
  //
  // /// 인터뷰연령대70대이상여부
  // final String? intvAge70Yn;
  //
  // /// 무직위여부(연령 성별 구분없이 Random하게 추출하는 지에 대한 여부,Y/N)
  // final String? intvAgeRandYn;

  InterviewReqModel({
    required this.id,
    this.userId,
    this.taskTpCd,
    this.etcTaskSubs,
    this.compNm,
    this.itemNm,
    this.item1LnIntroCn,
    required this.mainTitle,
    required this.subTitle,
    required this.intvMethTpCd,
    this.intvRewdAmt,
    required this.dueDate,
    required this.exceptTime,
    required this.minAge,
    required this.detail,
    required this.researchType,
    this.intvTgtZendTpCd,
    this.intvTgtSubs,
    this.intvEntryCnt,
    this.etcReqCn,
    this.intvPostAgreeYn,
    this.hpNum,
    this.email,
    this.delYn,
    this.frstRegtDt,
    this.finlUpdtDt,
  });

  factory InterviewReqModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewReqModelToJson(this);
}