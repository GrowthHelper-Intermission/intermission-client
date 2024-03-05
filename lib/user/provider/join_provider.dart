import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:intermission_project/research/model/research_model.dart';
import 'package:intermission_project/user/repository/join_repository.dart';

final joinProvider =
StateNotifierProvider<JoinStateNotifier, CursorPaginationBase>(
      (ref) {
    final repository = ref.watch(joinRepositoryProvider);
    final notifier = JoinStateNotifier(repository: repository);
    return notifier;
  },
);

class JoinStateNotifier
    extends PaginationProvider<ResearchModel, JoinRepository> {
  JoinStateNotifier({
    required super.repository,
  }): super(autoFetch: false) {
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

    final resp = await repository.getResearchDetail(id: id);

    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <ResearchModel>[
          ...pState.data,
          resp,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<ResearchModel>(
              (e) => e.id == id ? resp : e,
        )
            .toList(),
      );
    }
  }
}
