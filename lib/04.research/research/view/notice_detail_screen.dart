import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/view/user_point_count_screen.dart';
import 'package:intermission_project/04.research/research/model/noti_detail_model.dart';
import 'package:intermission_project/04.research/research/provider/notice_provider.dart';
import 'package:intermission_project/04.research/research/view/notice_screen.dart';
import 'package:intermission_project/common/view/default_layout.dart';

// static String get routeName => 'researchDetail';
// final String id;
// const ResearchDetailScreen({
// required this.id,
// super.key,
// });

class NoticeDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'notiDetail';
  final String id;

  const NoticeDetailScreen({
    super.key,
    required this.id,
  });
  @override
  ConsumerState<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends ConsumerState<NoticeDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(noticeProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(noticeDetailProvider(widget.id));

    // 데이터가 없거나 로딩 중인 경우
    if (state == null || state is! NotiDetailModel) {
      return Scaffold(body: renderLoading());
    }

    return DefaultLayout(
      title: '공지 세부 사항',
      child: Column(
        children: [
          Text(state.detail),
        ],
      ),
    );
  }
}
