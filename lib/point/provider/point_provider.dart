

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:intermission_project/point/model/point_model.dart';
import 'package:intermission_project/point/repository/point_repository.dart';


final pointProvider = StateNotifierProvider<PointStateNotifier, CursorPaginationBase>(
      (ref) {
    final repository = ref.watch(pointRepositoryProvider);
    return PointStateNotifier(repository: repository);
  },
);

class PointStateNotifier extends PaginationProvider<PointModel, PointRepository> {
  PointStateNotifier({
    required super.repository,
  }) : super(autoFetch: true) {
    paginate();
  }
}