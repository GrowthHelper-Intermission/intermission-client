// PointRepository
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/point/model/point_model.dart';
import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:intermission_project/03.management/noti/model/noti_model.dart';
import 'package:intermission_project/04.research/research/model/noti_detail_model.dart';
import 'package:intermission_project/04.research/research/model/noti_model.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:retrofit/retrofit.dart';

part 'noti_repository.g.dart';

final notiRepositoryProvider = Provider<NotiRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return NotiRepository(dio, baseUrl: 'http://34.64.77.5:8080/api/noti');
  },
);

@RestApi()
abstract class NotiRepository implements IBasePaginationRepository<NotiModel> {
  factory NotiRepository(Dio dio, {String baseUrl}) = _NotiRepository;

  @GET('{path}')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<NotiModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
    @Path() String path = '/',
    @Query('researchType') String? researchType,
  });


  @GET('/{id}') //Detailrestaurant용
  @Headers({
    'accessToken': 'true',
  })
  Future<NotiDetailModel> getNotiDetail({
    @Path() required String id,
  });

// Future<CursorPagination<ResearchModel>> paginate({
//   @Path() String path = '/', // 기본값을 root path로 설정
//   @Query('researchType') String? researchType,
//   @Queries() PaginationParams? paginationParams = const PaginationParams(),
// });
}