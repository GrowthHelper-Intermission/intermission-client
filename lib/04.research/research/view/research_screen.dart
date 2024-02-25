import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/component/research_card.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/user/user/model/user_model.dart';
import 'package:intermission_project/user/user/provider/user_me_provider.dart';

class ResearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'research';
  @override
  _ResearchScreenState createState() => _ResearchScreenState();
}

class _ResearchScreenState extends ConsumerState<ResearchScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // ref.read(researchProvider.notifier).paginate(forceRefetch: true,researchType: null);
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 4개의 탭
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userMeProvider);
    UserModel? user; // UserModel을 nullable

    if (userState is UserModel) {
      user = userState;
    }

    if (user == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    super.build(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: NormalAppbar(
          title: '리서치모음',
          color: PRIMARY_COLOR,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "안녕하세요 ${user.userName}님:)\n리서치 참여하고 포인트 받아가세요!",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: SvgPicture.asset(
                      'assets/img/circle/userColor.svg',
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              isScrollable: false,
              labelColor: PRIMARY_COLOR,
              indicatorColor: PRIMARY_COLOR,
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
                  _buildResearchPage(researchProvider), // "전체" 탭
                  _buildResearchPage(interviewProvider), // "인터뷰" 탭
                  _buildResearchPage(surveyProvider), // "설문조사" 탭
                  _buildResearchPage(testerProvider), // "테스트 참여" 탭
                ],
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

  Widget _buildResearchPage(
      StateNotifierProvider<ResearchStateNotifier, CursorPaginationBase>
          provider) {
    return PaginationListView(
      provider: provider,
      itemBuilder: <ResearchModel>(BuildContext context, int index, model) {
        return ResearchCard.fromModel(model: model);
      },
    );
  }
}
