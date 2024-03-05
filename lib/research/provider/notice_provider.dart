import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/notice/model/noti_model.dart';
import 'package:intermission_project/notice/repository/noti_repository.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:collection/collection.dart';

final noticeDetailProvider = Provider.family<NotiModel?, String>((ref, id) {
  final state = ref.watch(noticeProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id.toString() == id.toString());
});

final noticeProvider =
    StateNotifierProvider<NotiStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(notiRepositoryProvider);
    final notifier = NotiStateNotifier(repository: repository);
    return notifier;
  },
);

class NotiStateNotifier extends PaginationProvider<NotiModel, NotiRepository> {
  NotiStateNotifier({
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

    final resp = await repository.getNotiDetail(id: id.toString());

    if (pState.data.where((e) => e.id.toString() == id.toString()).isEmpty) {
      state = pState.copyWith(
        data: <NotiModel>[
          ...pState.data,
          resp,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<NotiModel>(
              (e) => e.id.toString() == id.toString() ? resp : e,
            )
            .toList(),
      );
    }
  }
}
