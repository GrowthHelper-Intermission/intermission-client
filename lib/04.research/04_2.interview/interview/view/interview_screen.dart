import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/component/interview_card.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/research_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/provider/research_provider.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_detail_screen.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_detail_test_screen.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:provider/provider.dart';

import '../../../../common/provider/pagination_provider.dart';
import '../../../../common/repository/base_pagination_repository.dart';


class InterviewScreen extends ConsumerStatefulWidget {
  static String get routeName => 'interview';
  @override
  _InterviewScreenState createState() => _InterviewScreenState();
}

class _InterviewScreenState extends ConsumerState<InterviewScreen> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);  // 4개의 탭
    // ref.read(interviewProvider.notifier).paginate();
    // ref.read(interviewInterviewProvider.notifier).paginate();
    // ref.read(surveyProvider.notifier).paginate();
    // ref.read(testerProvider.notifier).paginate();

  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("인터뷰모음",style: customTextStyle),
          centerTitle: false,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "안녕하세요 이도형님\n이 인터뷰는 어떠세요?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/img/userColor.png'),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              isScrollable: false,
              tabs: [
                _buildTabItem("전체"),
                _buildTabItem("인터뷰"),
                _buildTabItem("설문조사"),
                _buildTabItem("테스트 참여"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                  children: [
                    _buildInterviewPage(interviewProvider), // "전체" 탭
                    _buildInterviewPage(interviewInterviewProvider), // "인터뷰" 탭
                    _buildInterviewPage(surveyProvider), // "설문조사" 탭
                    _buildInterviewPage(testerProvider), // "테스트 참여" 탭
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4, // 4개의 탭이므로 화면 너비를 4로 나눔
      height: 50,
      child: Center(child: Text(title)),
    );
  }


  Widget _buildInterviewPage(StateNotifierProvider<ResearchStateNotifier, CursorPaginationBase> provider) {
    print("ha");
    return PaginationListView(
      provider: provider,
      itemBuilder: <InterviewModel>(BuildContext context, int index, model) {
        return ResearchCard.fromModel(model: model);
      },
    );
  }
}