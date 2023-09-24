
import 'package:intermission_project/04.research/research/model/comment_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'research_detail_model.g.dart';


@JsonSerializable()
class ResearchDetailModel extends ResearchModel{
  // final String isJoin;
  final int userId;
  final String isPossible;
  final String researchType;
  final String minAge;
  final String detail;
  final String researchEntryCnt;
  final String? researchCnt;
  final String isScrap;
  final String scrapCnt;
  final List<Comment> comments;  // comments 필드 추가

  // n,c 조건 추가
  final String? participationStatus; //"참여가능" ,참여중, 참여 완료
  final String? researchUrl;


  ResearchDetailModel({
    required this.userId,
    required super.id,
    required super.mainTitle,
    required super.subTitle,
    required super.dueDate,
    required super.exceptTime,
    required super.researchMethTpCd,
    required super.researchRewdAmt,
    required super.isOnGoing,
    required super.isBlock,
    super.researchRewdPoint,
    this.participationStatus,
    this.researchUrl,
    required this.detail,
    required this.researchType,
    required this.minAge,
    required this.researchEntryCnt,
    required this.researchCnt,
    required this.isScrap,
    required this.scrapCnt,
    required this.comments,
    required this.isPossible,
    //comment 필요ㄷ
});

  factory ResearchDetailModel.fromJson(Map<String, dynamic> json)
  => _$ResearchDetailModelFromJson(json);
}