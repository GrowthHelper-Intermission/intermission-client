import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'research_model.g.dart';



@JsonSerializable()
class ResearchModel implements IModelWithId {
  final String id; // PK
  final String mainTitle; // ex)뇌졸중 환자 및 보호자
  final String subTitle; //ex)온라인, 서울 관악구 기준 30분 거리면 오프라인 방문 가능
  final String dueDate; //yyyy-mm-dd
  final String exceptTime;
  final String researchMethTpCd;
  final String researchRewdAmt;
  final String isOnGoing;
  final String isBlock;
  final String? researchRewdPoint;

  ResearchModel({
    required this.id,
    required this.mainTitle,
    required this.subTitle,
    required this.dueDate,
    required this.exceptTime,
    required this.researchMethTpCd,
    required this.researchRewdAmt,
    required this.isOnGoing,
    required this.isBlock,
    this.researchRewdPoint,
  });

  factory ResearchModel.fromJson(Map<String, dynamic> json)
  => _$ResearchModelFromJson(json);

  Map<String,dynamic> toJson() => _$ResearchModelToJson(this);
}