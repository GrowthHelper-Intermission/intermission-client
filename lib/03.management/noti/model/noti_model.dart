// import 'package:json_annotation/json_annotation.dart';
//
// part 'noti_model.g.dart';
//
// @JsonSerializable()
// class NotiModel {
//   /// 게시물ID
//   final int notiNo;
//
//   /// 게시물내용
//   final String? notiSubs;
//
//   /// 게시사원붠호
//   final String? postEmpNo;
//
//   /// 상품코드
//   final String? prodNo;
//
//   /// 참여의뢰일자
//   final String? reqDay;
//
//   /// 참여의뢰일련번호
//   final String? reqSeqNo;
//
//   /// 최초등록일자
//   final DateTime? frstRegtDt;
//
//   /// 최초등록사원번호
//   final String? frstRegtEmpNo;
//
//   /// 최종수정일자
//   final DateTime? finlUpdtDt;
//
//   /// 최종수정사원번호
//   final String? finlUpdtEmpNo;
//
//   NotiModel({
//     required this.notiNo,
//     this.notiSubs,
//     this.postEmpNo,
//     this.prodNo,
//     this.reqDay,
//     this.reqSeqNo,
//     this.frstRegtDt,
//     this.frstRegtEmpNo,
//     this.finlUpdtDt,
//     this.finlUpdtEmpNo,
//   });
//
//   factory NotiModel.fromJson(Map<String, dynamic> json)
//   => _$NotiModelFromJson(json);
//
//   Map<String,dynamic> toJson() => _$NotiModelToJson(this);
// }
