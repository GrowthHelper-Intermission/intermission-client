import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/view/user_point_count_screen.dart';
import 'package:intermission_project/04.research/research/component/research_card.dart';
import 'package:intermission_project/04.research/research/model/noti_model.dart';
import 'package:intermission_project/04.research/research/provider/notice_provider.dart';
import 'package:intermission_project/04.research/research/view/notice_card.dart';
import 'package:intermission_project/04.research/research/view/notice_detail_screen.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:skeletons/skeletons.dart';

class NoticeScreen extends ConsumerStatefulWidget {
  static String get routeName => 'noti';

  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends ConsumerState<NoticeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noticeProvider);

    // 데이터가 없거나 로딩 중인 경우
    if (state is CursorPaginationLoading || state == null) {
      return Scaffold(body: renderLoading());
    }

    return DefaultLayout(
      title: '공지사항',
      child: Column(
        children: [
          _buildNoticePage(noticeProvider),
        ],
      ),
    );
  }

  Widget _buildNoticeDetail({
    required String date,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(date, style: TextStyle(color: Colors.grey[400])),
      onTap: onTap,
    );
  }

  Widget _buildNoticePage(StateNotifierProvider<NotiStateNotifier, CursorPaginationBase> provider) {
    return Expanded(
      child: PaginationListView(
        provider: provider,
        itemBuilder: <NotiModel>(BuildContext context, int index, model) {
          return NoticeCard.fromModel(model);
        },
      ),
    );
  }

  // Widget _buildInterviewPage(StateNotifierProvider<ResearchStateNotifier, CursorPaginationBase> provider) {
  //   return PaginationListView(
  //     provider: provider,
  //     itemBuilder: <ResearchModel>(BuildContext context, int index, model) {
  //       return ResearchCard.fromModel(model: model);
  //     },
  //   );
  // }
}
