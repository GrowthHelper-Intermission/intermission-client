import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/component/interview_card.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/provider/interview_provider.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_detail_screen.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_detail_test_screen.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';

// class InterviewScreen extends StatelessWidget {
//   static String get routeName => 'interview';
//   const InterviewScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return PaginationListView(
//       provider: interviewProvider,
//       itemBuilder: <InterviewModel>(_, index, model) {
//         return InterviewCard.fromModel(model: model);
//       },
//     );
//   }
// }


class InterviewScreen extends StatefulWidget {
  static String get routeName => 'interview';
  @override
  _InterviewScreenState createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);  // 4개의 탭
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
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
                children: List.generate(4, (index) => _buildInterviewPage()),
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

  Widget _buildInterviewPage() {
    return PaginationListView(
      provider: interviewProvider,
      itemBuilder: <InterviewModel>(_, index, model)  {
        return InterviewCard.fromModel(model: model);
      },
    );
  }
}