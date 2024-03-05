import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:intermission_project/point/model/point_change_model.dart';
import 'package:intermission_project/point/model/point_change_response.dart';
import 'package:intermission_project/point/model/point_model.dart';
import 'package:intermission_project/research/model/friend_code_model.dart';
import 'package:intermission_project/user/model/friend_code_response.dart';
import 'package:retrofit/retrofit.dart';

part 'point_repository.g.dart';

final pointRepositoryProvider = Provider<PointRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return PointRepository(dio, baseUrl: '$ip/api');
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

  @POST('/point')
  @Headers({
    'accessToken':'true',
  })
  Future<PointChangeResponse> changePoint({
    @Body() required PointChangeModel pointChangeModel,
  });

  @GET('/code')
  @Headers({
    'accessToken':'true',
  })
  Future<FriendCodeResponse> getCode();

  @POST('/code')
  @Headers({
    'accessToken':'true',
  })
  Future<PointChangeResponse> registerCode({
    @Body() required FriendRecommendCodeModel friendRecommendCodeModel,
  });

}