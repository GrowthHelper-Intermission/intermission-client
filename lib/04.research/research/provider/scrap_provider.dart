import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:intermission_project/04.research/research/repository/research_repository.dart';
import 'package:intermission_project/04.research/research/repository/scrap_repository.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:collection/collection.dart';

// final scrapDetailProvider =
// Provider.family<ResearchModel?, String>((ref, id) {
//   final state = ref.watch(scrapProvider);
//
//   if (state is! CursorPagination) {
//     return null;
//   }
//
//   return state.data.firstWhereOrNull((element) => element.id == id);
// });

final scrapProvider =
StateNotifierProvider<ScrapStateNotifier, CursorPaginationBase>(
      (ref) {
    final repository = ref.watch(scrapRepositoryProvider);
    final notifier = ScrapStateNotifier(repository: repository);
    return notifier;
  },
);

class ScrapStateNotifier
    extends PaginationProvider<ResearchModel, ScrapRepository> {
  ScrapStateNotifier({
    required super.repository,
  }): super(autoFetch: false) {
    paginate();
  }

  Future<ParticipationResponse> scrapResearch({required String id}) async {
    return await repository.scrapResearch(id: id);
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
