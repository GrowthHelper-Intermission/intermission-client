import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/notice/component/notice_card.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/layout/default_layout.dart';
import 'package:intermission_project/common/component/render_loading.dart';
import 'package:intermission_project/research/provider/notice_provider.dart';
import 'package:intermission_project/point/view/point_history_screen.dart';

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

  String formatDate(String dateTime) {
    return dateTime.substring(0, 10);
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noticeProvider);

    // 데이터가 없거나 로딩 중인 경우
    if (state is CursorPaginationLoading) {
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
}
