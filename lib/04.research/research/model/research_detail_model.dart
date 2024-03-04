import 'package:intermission_project/04.research/research/model/comment_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'research_detail_model.g.dart';

@JsonSerializable()
class ResearchDetailModel extends ResearchModel {
  final String researchType;
  final String minAge;
  final String detail;
  final int researchTargetCnt;
  final int researchCurrentCnt;
  final String isScrap;
  final int scrapCnt;
  final List<Comment> comments;
  final String researchUrl;

  ResearchDetailModel({
    required super.id,
    required super.mainTitle,
    required super.subTitle,
    required super.dueDate,
    required super.exceptTime,
    required super.researchMethTpCd,
    required super.researchRewdPoint,
    required super.isEligible,
    required this.researchUrl,
    required this.detail,
    required this.researchType,
    required this.minAge,
    required this.researchCurrentCnt,
    required this.researchTargetCnt,
    required this.isScrap,
    required this.scrapCnt,
    required this.comments,
  });

  factory ResearchDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ResearchDetailModelFromJson(json);
}
