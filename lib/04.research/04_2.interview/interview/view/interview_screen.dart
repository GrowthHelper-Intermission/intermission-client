import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/component/interview_card.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/provider/interview_provider.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_detail_screen.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';

class InterviewScreen extends StatelessWidget {
  static String get routeName => 'interview';
  const InterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<InterviewModel>(
      provider: interviewProvider,
      itemBuilder: <InterviewModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            // context.go('/restaurant/${model.id}');
            context.goNamed(InterviewDetailScreen.routeName,
                pathParameters: {'rid': model.id});
          },
          child: InterviewCard.fromModel(model: model),
        );
      },
    );
  }
}
