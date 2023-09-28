import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/report_model.dart';
import 'package:intermission_project/01.user/user/repository/report_repository.dart';
import 'package:intermission_project/04.research/research/model/noti_model.dart';
import 'package:intermission_project/04.research/research/repository/noti_repository.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:collection/collection.dart';

final reportDetailProvider = Provider.family<ReportModel?, String>((ref, id) {
  final state = ref.watch(reportProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final reportProvider =
StateNotifierProvider<ReportStateNotifier, CursorPaginationBase>(
      (ref) {
    final repository = ref.watch(reportRepositoryProvider);
    final notifier = ReportStateNotifier(repository: repository);
    return notifier;
  },
);

class ReportStateNotifier extends PaginationProvider<ReportModel, ReportRepository> {
  ReportStateNotifier({
    required super.repository,
  }) : super(autoFetch: true) {
    paginate();
  }

  getDetail({
    required String id,
  }) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final resp = await repository.getReportDetail(id: id);

    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <ReportModel>[
          ...pState.data,
          resp,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<ReportModel>(
              (e) => e.id == id ? resp : e,
        )
            .toList(),
      );
    }
  }
}
