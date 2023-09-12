import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/component/research_card.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/04.research/research/provider/scrap_provider.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:provider/provider.dart';

class ParticipatedResearchScreen extends ConsumerStatefulWidget {
  const ParticipatedResearchScreen({super.key});

  @override
  _ParticipatedResearchScreenState createState() => _ParticipatedResearchScreenState();
}

class _ParticipatedResearchScreenState extends ConsumerState<ParticipatedResearchScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    print('crash');
    ref.read(scrapProvider.notifier).paginate();
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3개의 탭
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '참여한 리서치',
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: false,
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

  Widget _buildTabContent(String title) {
    if (title == "전체") {
      ref.read(researchProvider.notifier).paginate();
    } else if (title == "진행중" || title == "마감") {
      ref.read(researchProvider.notifier).paginate();
    }

    // 데이터의 상태를 확인합니다.
    final state = ref.watch(scrapProvider);

    if (state == null || state is! CursorPagination) {
      return Center(child: CircularProgressIndicator());
    } else {
      return _buildInterviewPage(researchProvider);
    }
  }




  Widget _buildInterviewPage(StateNotifierProvider<ResearchStateNotifier, CursorPaginationBase> provider) {
    return PaginationListView(
      provider: provider,
      itemBuilder: <ResearchModel>(BuildContext context, int index, model) {
        return ResearchCard.fromModel(model: model);
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