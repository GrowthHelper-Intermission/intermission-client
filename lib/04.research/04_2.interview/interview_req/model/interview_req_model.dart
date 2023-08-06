import 'package:json_annotation/json_annotation.dart';

part 'interview_req_model.g.dart';

@JsonSerializable()
class InterviewReqModel {
  /// 인터뷰의뢰일자(PK)
  final String intvReqDay;

  /// 인터뷰의뢰일련번호(PK)
  final String intvReqSeqNo;

  /// 회원번호(의뢰하는 userId)
  final String? membNo;

  /// 상품번호('200'으로 고정)
  final String? prodNo;

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

  /// 인터뷰명
  final String? intvNm;

  /// 인터뷰방법구분코드(변경예정 10,20,30,99)
  final String? intvMethTpCd;

  /// 예상소요시간(분단위 입력)
  final int? expectTakeTm;

  /// 인터뷰보상금액(정수만 입력)
  final int? intvRewdAmt;

  // /// 인터뷰대상대분류코드(예비 - 향후 산업분야 또는 사회 특정 행사 구분)
  // final String? intvTgtLgrTpCd;
  //
  // /// 인터뷰대상중분류코드(예비 - 대분류에 포함된 세부 대상을 의해 생성)
  // final String? intvTgtMidTpCd;

  /// 인터뷰대상성별코드(M/F)
  final String? intvTgtZendTpCd;

  /// 인터뷰연령대10대여부(Y/N, Default = 'N')
  final String? intvAge10Yn;

  /// 인터뷰연령대20대여부
  final String? intvAge20Yn;

  /// 인터뷰연령대30대여부
  final String? intvAge30Yn;

  /// 인터뷰연령대40대여부
  final String? intvAge40Yn;

  /// 인터뷰연령대50대여부
  final String? intvAge50Yn;

  /// 인터뷰연령대60대여부
  final String? intvAge60Yn;

  /// 인터뷰연령대70대이상여부
  final String? intvAge70Yn;

  /// 무직위여부(연령 성별 구분없이 Random하게 추출하는 지에 대한 여부,Y/N)
  final String? intvAgeRandYn;

  /// 인터뷰대상내용(인터뷰 세부 설명)
  final String? intvTgtSubs;

  /// 인터뷰대상인원수
  final int? intvEntryCnt;

  /// 기타요청사항내용
  final String? etcReqCn;

  /// 인터뷰게시동의여부
  final String? intvPostAgreeYn;

  // /// 핸드폰사업번호
  // final String? hpBizNo;
  //
  // /// 핸드폰국번호
  // final String? hpExchgNo;
  //
  // /// 핸드폰회선번호
  // final String? hpLineNo;
  //
  // /// 유선전화지역번호
  // final String? cablePhonAreaNo;
  //
  // /// 유선전화국번호
  // final String? cablePhonExchgNo;
  //
  // /// 유선전화회선번호
  // final String? cablePhonLineNo;

  final String? hpNum;

  /// EMAIL주소(User정보에서 가져와야함)
  final String? email;

  /// 참여마감일자(YYYY-MM-DD)
  final String? joinClosDay;

  /// 삭제여부(물리적인 삭제는 없으며, Flag 처리)
  final String? delYn;

  /// 최초입력일시(데이터를 입력한 최초 일시 , SYSTEM DATE)
  final DateTime? frstRegtDt;

  /// 최종수정일시
  final DateTime? finlUpdtDt;

  InterviewReqModel({
    required this.intvReqDay,
    required this.intvReqSeqNo,
    this.membNo,
    this.prodNo,
    this.taskTpCd,
    this.etcTaskSubs,
    this.compNm,
    this.itemNm,
    this.item1LnIntroCn,
    this.intvNm,
    this.intvMethTpCd,
    this.expectTakeTm,
    this.intvRewdAmt,
    // this.intvTgtLgrTpCd,
    // this.intvTgtMidTpCd,
    this.intvTgtZendTpCd,
    this.intvAge10Yn,
    this.intvAge20Yn,
    this.intvAge30Yn,
    this.intvAge40Yn,
    this.intvAge50Yn,
    this.intvAge60Yn,
    this.intvAge70Yn,
    this.intvAgeRandYn,
    this.intvTgtSubs,
    this.intvEntryCnt,
    this.etcReqCn,
    this.intvPostAgreeYn,
    // this.hpBizNo,
    // this.hpExchgNo,
    // this.hpLineNo,
    // this.cablePhonAreaNo,
    // this.cablePhonExchgNo,
    // this.cablePhonLineNo,
    this.hpNum,
    this.email,
    this.joinClosDay,
    this.delYn,
    this.frstRegtDt,
    this.finlUpdtDt,
  });

  factory InterviewReqModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewReqModelToJson(this);
}