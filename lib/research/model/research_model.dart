import 'package:intermission_project/models/model_with_id.dart';

enum researchCategory{
  interview,
  survey,
  appTester,
  experiment,
}

enum onlineCategory{
  online,
  offline,
  both,
}

class ResearchModel implements IModelWithId {
  final String researchId;
  final researchCategory category;
  final String mainTitle;
  final String subTitle;
  final onlineCategory isOnline;
  final String hourlyRate;
  final String dueDate;
  final bool isOnGoing;

  ResearchModel({
    required this.researchId,
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.dueDate,
    required this.isOnline,
    required this.hourlyRate,
    required this.isOnGoing,
  });
}
