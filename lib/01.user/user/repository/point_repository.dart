// PointRepository
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/point/model/point_model.dart';
import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:retrofit/retrofit.dart';

part 'point_repository.g.dart';

final pointRepositoryProvider = Provider<PointRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return PointRepository(dio, baseUrl: 'http://$ip/api/user');
  },
);

@RestApi()
abstract class PointRepository implements IBasePaginationRepository<PointModel> {
  factory PointRepository(Dio dio, {String baseUrl}) = _PointRepository;

  @GET('/point')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<PointModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
    @Path() String path = '/',
    @Query('researchType') String? researchType,
  });
}