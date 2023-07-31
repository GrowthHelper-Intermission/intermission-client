import 'package:intermission_project/models/model_with_id.dart';
import 'package:intermission_project/research/model/research_model.dart';

class ResearchDetailModel extends ResearchModel {
  final String interviewDetail;
  final String requesterName;
  final String requesterCompany;
  final String requesterJob;
  final int joinCount;
  final int scrapCount;
  final String minJoinRequired;
  final String commentId;

  ResearchDetailModel({
    required super.researchId,
    required super.category,
    required super.mainTitle,
    required super.subTitle,
    required super.isOnline,
    required super.hourlyRate,
    required super.dueDate,
    required super.isOnGoing,
    required this.interviewDetail,
    required this.requesterName,
    required this.requesterCompany,
    required this.requesterJob,
    required this.joinCount,
    required this.scrapCount,
    required this.minJoinRequired,
    required this.commentId,
  });
}
