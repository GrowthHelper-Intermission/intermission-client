import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/component/research_card.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';

class OngoingResearchList extends ConsumerWidget {
  const OngoingResearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(researchProvider.notifier).paginate();
    final interviewNotifier = ref.read(researchProvider.notifier);
    final ongoingInterviews = interviewNotifier.getTopThreeResearches();

    final interviewState = ref.read(researchProvider);

    if (interviewState is! CursorPagination || ongoingInterviews.isEmpty) {
      return Container(
        height: 441,
        child: Center(
          child: Text("현재 진행 중인 리서치가 없습니다."), // or another appropriate widget
        ),
      );
    }

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
