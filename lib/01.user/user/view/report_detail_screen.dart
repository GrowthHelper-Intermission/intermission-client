import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/report_detail_model.dart';
import 'package:intermission_project/01.user/user/provider/report_provider.dart';
import 'package:intermission_project/01.user/user/view/user_point_count_screen.dart';
import 'package:intermission_project/common/view/default_layout.dart';

// static String get routeName => 'researchDetail';
// final String id;
// const ResearchDetailScreen({
// required this.id,
// super.key,
// });

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

    // 데이터가 없거나 로딩 중인 경우
    if (state == null || state is! ReportDetailModel) {
      return Scaffold(body: renderLoading());
    }

    return DefaultLayout(
      title: '문의 세부 사항',
      child: Column(
        children: [
          Text(state.detail),
        ],
      ),
    );
  }
}
