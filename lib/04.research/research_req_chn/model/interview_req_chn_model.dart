import 'package:json_annotation/json_annotation.dart';

part 'interview_req_chn_model.g.dart';

@JsonSerializable()
class InterviewReqChn {
  /// 인터뷰를 의뢰한 일자(PK, FK)
  final String intvReqDay;

  /// 인터뷰를 의뢰한 일자의 의뢰 순번(PK, FK)
  final String intvReqSeqNo;

  /// 인터뷰 의뢰에 접근할 수 있게해준 채널코드(PK)
  final String chnCd;

  /// 비고
  final String? remark;

  /// 물리적인 삭제는 없음, Flag 처리
  final String? delYn;

  /// 데이터를 최초로 입력한 일시, SYSTEM DATE
  final DateTime? frstRegtDt;

  /// 데티어를 수정한 최종 일시, SYSTEM DATE
  final DateTime? finlUpdtDt;

  InterviewReqChn({
    required this.intvReqDay,
    required this.intvReqSeqNo,
    required this.chnCd,
    this.remark,
    this.delYn,
    this.frstRegtDt,
    this.finlUpdtDt,
  });

  factory InterviewReqChn.fromJson(Map<String, dynamic> json) => _$InterviewReqChnFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewReqChnToJson(this);
}
