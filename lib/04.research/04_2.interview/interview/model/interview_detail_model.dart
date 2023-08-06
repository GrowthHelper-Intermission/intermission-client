

import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_detail_model.g.dart';


@JsonSerializable()
class InterviewDetailModel extends InterviewModel{
  final String detail;

  InterviewDetailModel({
    required super.id,
    required super.mainTitle,
    required super.subTitle,
    required super.isOnline,
    required super.hourlyRate,
    required super.dueDate,
    required super.isOnGoing,
    required this.detail,
    //comment 필요
});

  factory InterviewDetailModel.fromJson(Map<String, dynamic> json)
  => _$InterviewDetailModelFromJson(json);
}