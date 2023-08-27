
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
    //comment 필요
});

  factory ResearchDetailModel.fromJson(Map<String, dynamic> json)
  => _$ResearchDetailModelFromJson(json);
}