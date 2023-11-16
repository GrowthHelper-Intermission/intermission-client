import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/component/research_card.dart';
import 'package:intermission_project/04.research/research/model/scrap_card.dart';
import 'package:intermission_project/04.research/research/provider/scrap_provider.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/view/default_layout.dart';

class ScrapedResearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'scrap';
  const ScrapedResearchScreen({super.key});

  @override
  _ScrapedResearchScreenState createState() => _ScrapedResearchScreenState();
}

class _ScrapedResearchScreenState extends ConsumerState<ScrapedResearchScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(scrapProvider.notifier).paginate();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '스크랩',
      child: Column(
        children: [
          TabBar(
            isScrollable: false,
            labelColor: PRIMARY_COLOR,
            indicatorColor: PRIMARY_COLOR,
            controller: _tabController,
            tabs: [
              _buildTabItem("전체"),
              _buildTabItem("진행중"),
              _buildTabItem("마감"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent("전체"),
                _buildTabContent("진행중"),
                _buildTabContent("마감"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildTabContent(String title) {
  //   if (title == "전체") {
  //     ref.read(scrapProvider.notifier).paginate();
  //   } else if (title == "진행중" || title == "마감") {
  //     ref.read(scrapProvider.notifier).paginate();
  //   }
  // }

  Widget _buildTabContent(String title) {
    if (title == "전체") {
      ref.read(scrapProvider.notifier).paginate();
    } else if (title == "진행중" || title == "마감") {
      ref.read(scrapProvider.notifier).paginate();
    }

    // 데이터의 상태를 확인합니다.
    final state = ref.watch(scrapProvider);

    if (state == null || state is! CursorPagination) {
      return Center(
        child: CircularProgressIndicator(
          color: PRIMARY_COLOR,
        ),
      );
    } else {
      return _buildResearchPage(
        scrapProvider,
        title,
      );
    }
  }

  Widget _buildResearchPage(
      StateNotifierProvider<ScrapStateNotifier, CursorPaginationBase> provider,
      String title) {
    return PaginationListView(
      provider: provider,
      itemBuilder:
          <ScrapResearchModel>(BuildContext context, int index, model) {
        if (title == "진행중" && model.isOnGoing != 'Y') return SizedBox.shrink();
        if (title == "마감" && model.isOnGoing != 'N') return SizedBox.shrink();
        return ScrapResearchCard.fromModel(model: model);
      },
    );
  }

  Widget _buildTabItem(String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3, // 3개의 탭이므로 화면 너비를 3로 나눔
      height: 50,
      child: Center(child: Text(title)),
    );
  }
}
