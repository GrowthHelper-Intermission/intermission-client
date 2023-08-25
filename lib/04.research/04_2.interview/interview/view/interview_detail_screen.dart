import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/component/interview_card.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/research_detail_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/research_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/provider/research_provider.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/utils/pagination_utils.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:skeletons/skeletons.dart';

class InterviewDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'interviewDetail';
  final String id;
  const InterviewDetailScreen({
    required this.id,
    super.key,
  });

  @override
  ConsumerState<InterviewDetailScreen> createState() =>
      _InterviewDetailScreenState();
}

class _InterviewDetailScreenState extends ConsumerState<InterviewDetailScreen> {
  // final ScrollController controller = ScrollController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(interviewProvider.notifier).getDetail(id: widget.id);
    ref.read(interviewInterviewProvider.notifier).getDetail(id: widget.id);
    ref.read(surveyProvider.notifier).getDetail(id: widget.id);
    ref.read(testerProvider.notifier).getDetail(id: widget.id);
  }

  // void listener() {
  //   //댓글로 수정
  //   PaginationUtils.paginate(
  //     controller: controller,
  //     provider: ref.read(restaurantRatingProvider(widget.id).notifier),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final interviewState = ref.watch(interviewDetailProvider(widget.id));
    //     final testerState = ref.watch(testerDetailProvider(widget.id));
    // final surveyState = ref.watch(surveyDetailProvider(widget.id));
    //
    // final interviewInterviewState = ref.watch(interviewInterviewDetailProvider(widget.id));


    //final state = testerState ?? surveyState ?? interviewState ?? interviewInterviewState;

    final state= interviewState;

    print('statre');

    if(state == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // if (state is! InterviewDetailModel) renderLoading();
    return Scaffold(

      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              context.go('/'); // 현재의 라우트를 1 단계 되돌립니다.
            },
          )),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Text(state.mainTitle),
            // Text(state.hourlyRate),
            // Text(state.isOnline.toString()),
            if (state is! ResearchModel) renderLoading(),
            if (state is ResearchDetailModel)
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.researchType,
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(state.mainTitle),
                    Text(state.subTitle),
                    Text(state.exceptTime),
                    Text(state.researchType),
                    Text(state.researchRewdAmt),
                    Text(state.researchMethTpCd),
                    Text(state.dueDate),
                    Text(state.id),
                    Text(state.isOnGoing),
                    Text(state.detail),
                    Text(state.minAge),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
