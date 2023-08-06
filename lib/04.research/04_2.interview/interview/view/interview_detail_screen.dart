import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/provider/interview_provider.dart';
import 'package:intermission_project/common/layout/default_layout.dart';
import 'package:provider/provider.dart';


class InterviewDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'interviewDetail';
  final String id;
  const InterviewDetailScreen({required this.id, super.key});

  @override
  ConsumerState<InterviewDetailScreen> createState() => _InterviewDetailScreenState();
}

class _InterviewDetailScreenState extends ConsumerState<InterviewDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(interviewProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(interviewDetailProvider(widget.id));
    // final ratingsState = ref.watch(restaurantRatingProvider(widget.id));
    // final basket = ref.watch(basketProvider); //badge를 위함

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return const Placeholder();
  }
}
