import 'package:json_annotation/json_annotation.dart';

part 'research_req_model.g.dart';

@JsonSerializable()
class ResearchReqModel {
  // /// 인터뷰 유일 ID(PK) 필수
  // final String id;

  /// 인터뷰명
  final String mainTitle;

  /// 부제목
  final String subTitle;

  /// 예정 날짜 (2022-02-03)
  final String dueDate;

  /// 예상 소요 시간
  final String exceptTime;

  /// 최소 연령대(이후에 8개의 bool 타입으로 바꿀 예정 일단 String)
  final String minAge;

  /// 인터뷰 설명
  final String detail;

  /// 리서치 종류(인터뷰, 설문, 테스트)
  final String researchType;

  /// 인터뷰 방법(온라인, 오프라인, 기존의 isOnline변수)
  final String researchMethTpCd;

  /// 보상 금액(1만원, 2만원, 기존의 hourlyRate 변수)
  final String? researchRewdAmt;

  //// 여기까지가 유저가 앱에서 보이는 것들 (기존에 테스트했던 10개의 변수 그대로)

  /// 회원번호(일단 임의로 한개 지정, 의뢰하는 userId) 필수
  final String? userId;

  /// EMAIL주소(일단 임의로 한개 지정!!! User정보에서 가져와야함. GET 요청 필수)
  final String? email;

  /// 직무유형코드(개발,디자인 등등, 테스트후 변경 예정 10,20,30,40,90,99)
  final String? taskTpCd;

  /// 기타직급내용(99일때만 입력하게끔)
  final String? etcTaskSubs;

  /// 회사명(회사명, 학교명, 단체명 등 소속 조직의 명칭)
  final String? compNm;

  /// 인터뷰대상성별코드(M/F)
  final String? researchTgtZendTpCd;

  /// 인터뷰대상인원수
  final String? researchEntryCnt;

  /// 기타요청사항내용(조건사항, 원하는 인터뷰 인원 특성, 조건기입하기)
  final String? etcReqCn;

  /// 인터뷰게시동의여부
  final String? researchPostAgreeYn;

  /// 선택적 기입(의뢰자가 기업소속이나, 다른 단체 휴대폰 있을때 위함)
  final String? hpNum;

  /// 삭제여부(물리적인 삭제는 없으며, Flag 처리)
  final String? delYn;

  // /// 최초입력일시(데이터를 입력한 최초 일시 , SYSTEM DATE)
  // final DateTime? frstRegtDt;
  //
  // /// 최종수정일시
  // final DateTime? finlUpdtDt;

  // /// 아이템명
  // final String? itemNm;
  //
  // /// 아이템한줄소개내용
  // final String? item1LnIntroCn;

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

  ResearchReqModel({
    this.userId,
    this.taskTpCd,
    this.etcTaskSubs,
    this.compNm,
    required this.mainTitle,
    required this.subTitle,
    required this.researchMethTpCd,
    this.researchRewdAmt,
    required this.dueDate,
    required this.exceptTime,
    required this.minAge,
    required this.detail,
    required this.researchType,
    this.researchTgtZendTpCd,
    this.researchEntryCnt,
    this.etcReqCn,
    this.researchPostAgreeYn,
    this.hpNum,
    this.email,
    this.delYn,
  });

  factory ResearchReqModel.fromJson(Map<String, dynamic> json) =>
      _$ResearchReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResearchReqModelToJson(this);
}