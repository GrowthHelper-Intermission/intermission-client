import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scrap_research_model.g.dart';



@JsonSerializable()
class ScrapResearchModel implements IModelWithId  {
  final int id; // PK
  final String mainTitle; // ex)뇌졸중 환자 및 보호자
  final String subTitle; //ex)온라인, 서울 관악구 기준 30분 거리면 오프라인 방문 가능
  final String dueDate; //yyyy-mm-dd
  final String exceptTime;
  final String researchMethTpCd;
  final String researchRewdPoint;
  final String isEligible;
  final String researchType;

  ScrapResearchModel({
    required this.id,
    required this.mainTitle,
    required this.subTitle,
    required this.dueDate,
    required this.exceptTime,
    required this.researchMethTpCd,
    required this.researchRewdPoint,
    required this.isEligible,
    required this.researchType,
  });

  factory ScrapResearchModel.fromJson(Map<String, dynamic> json)
  => _$ScrapResearchModelFromJson(json);

  Map<String,dynamic> toJson() => _$ScrapResearchModelToJson(this);
}