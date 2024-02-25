import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/notice/noti_detail_model.dart';
import 'package:intermission_project/notice/noti_model.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:retrofit/retrofit.dart';

part 'noti_repository.g.dart';

final notiRepositoryProvider = Provider<NotiRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return NotiRepository(dio, baseUrl: '$ip/api/noti');
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
}