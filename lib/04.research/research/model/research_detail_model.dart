
import 'package:intermission_project/04.research/research/model/comment_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'research_detail_model.g.dart';


@JsonSerializable()
class ResearchDetailModel extends ResearchModel{
  // final String isJoin;
  final String researchType;
  final String minAge;
  final String detail;
  final String researchEntryCnt;
  final String researchCnt;
  final String isJoin;
  final String isScrap;
  final String scrapCnt;
  final List<Comment> comments;  // comments 필드 추가


  ResearchDetailModel({
    // required this.isJoin,
    required super.id,
    required super.mainTitle,
    required super.subTitle,
    required super.dueDate,
    required super.exceptTime,
    required super.researchMethTpCd,
    required super.researchRewdAmt,
    required super.isOnGoing,
    required this.detail,
    required this.researchType,
    required this.minAge,
    required this.researchEntryCnt,
    required this.researchCnt,
    required this.isJoin,
    required this.isScrap,
    required this.scrapCnt,
    required this.comments,
    //comment 필요ㄷ
});

  factory ResearchDetailModel.fromJson(Map<String, dynamic> json)
  => _$ResearchDetailModelFromJson(json);
}