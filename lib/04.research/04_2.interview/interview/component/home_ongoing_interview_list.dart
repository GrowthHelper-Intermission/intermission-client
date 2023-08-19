import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/component/interview_card.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/provider/research_provider.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';

class OngoingResearchList extends ConsumerWidget {
  const OngoingResearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interviewNotifier = ref.watch(interviewProvider.notifier);
    final ongoingInterviews = interviewNotifier.getTopThreeResearches();

    final interviewState = ref.watch(interviewProvider);

    if (interviewState is! CursorPagination) {
      return Container(
        height: 441,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 최신 데이터 순으로 인터뷰 목록을 정렬
    ongoingInterviews.sort((a, b) => b.dueDate.compareTo(a.dueDate));

    print(ongoingInterviews);

    final int itemCount =
        (ongoingInterviews.length > 3) ? 3 : ongoingInterviews.length;

    return Expanded(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final interview = ongoingInterviews[index];
          return ResearchCard.fromModel(model: interview);
        },
      ),
    );
  }
}
