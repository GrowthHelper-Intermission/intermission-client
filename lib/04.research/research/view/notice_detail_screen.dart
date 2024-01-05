import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/view/user_point_count_screen.dart';
import 'package:intermission_project/04.research/research/model/noti_detail_model.dart';
import 'package:intermission_project/04.research/research/provider/notice_provider.dart';
import 'package:intermission_project/04.research/research/view/notice_screen.dart';
import 'package:intermission_project/common/view/default_layout.dart';

import '../../../common/component/custom_text_style.dart';
import '../../../common/const/colors.dart';

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
      title: '문의 세부 사항',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.title,
              style: customHeaderStyle,
            ),
            Divider(color: Colors.grey[400],thickness: 0.5,),
            Text(
              '세부 내용',
              style: greyBigTextStyle,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TEXT_GREY_COLOR,
                    ),
                    color: Colors.white, // 배경색 설정
                    borderRadius: BorderRadius.circular(6), // 모서리 둥글게 설정
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.content,
                          style: blackSmallTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
