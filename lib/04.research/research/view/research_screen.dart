import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/04.research/research/component/research_card.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';


class ResearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'research';
  @override
  _ResearchScreenState createState() => _ResearchScreenState();
}

class _ResearchScreenState extends ConsumerState<ResearchScreen> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  TabController? _tabController;



  @override
  bool get wantKeepAlive => true;

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
    final userState = ref.watch(userMeProvider); // 상태를 읽어옴
    UserModel? user; // UserModel을 nullable로 선언

    if (userState is UserModel) {
      user = userState; // UserModel로 캐스팅
    }

    int point = 0;

    if (user == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    super.build(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: NormalAppbar(title: '리서치모음',),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "안녕하세요 ${user.userNm}님\n이 인터뷰는 어떠세요?",
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
                    _buildInterviewPage(researchProvider), // "전체" 탭
                    _buildInterviewPage(interviewProvider), // "인터뷰" 탭
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
    return PaginationListView(
      provider: provider,
      itemBuilder: <ResearchModel>(BuildContext context, int index, model) {
        return ResearchCard.fromModel(model: model);
      },
    );
  }
}