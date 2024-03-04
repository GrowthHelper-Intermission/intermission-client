import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/component/render_loading.dart';
import 'package:intermission_project/report/report_detail_model.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/report/report_provider.dart';

class ReportDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'reportDetail';
  final String id;

  const ReportDetailScreen({
    super.key,
    required this.id,
  });
  @override
  ConsumerState<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends ConsumerState<ReportDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(reportProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportDetailProvider(widget.id));

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 데이터가 없거나 로딩 중인 경우
    if (state == null || state is! ReportDetailModel) {
      return Scaffold(body: renderLoading());
    }

    String formatDate(String dateTime) {
      return dateTime.substring(0, 10);
    }

    return DefaultLayout(
      title: '문의 세부 사항',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.mainTitle,
              style: customHeaderStyle,
            ),
            Text(
              formatDate(state.postDate),
              style: customNoticeDateStyle,
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.detail,
                    style: blackSmallTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
