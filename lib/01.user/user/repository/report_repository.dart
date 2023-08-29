// PointRepository
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/point/model/point_model.dart';
import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:intermission_project/01.user/user/model/report_detail_model.dart';
import 'package:intermission_project/01.user/user/model/report_model.dart';
import 'package:intermission_project/01.user/user/model/report_req_model.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:retrofit/retrofit.dart';

part 'report_repository.g.dart';

final reportRepositoryProvider = Provider<ReportRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return ReportRepository(dio, baseUrl: 'http://34.64.77.5:8080/api/ask');
  },
);

@RestApi()
abstract class ReportRepository implements IBasePaginationRepository<ReportModel> {
  factory ReportRepository(Dio dio, {String baseUrl}) = _ReportRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<ReportModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
    @Path() String path = '/',
    @Query('researchType') String? researchType,
  });

  @GET('/{id}') //Detailrestaurant용
  @Headers({
    'accessToken': 'true',
  })
  Future<ReportDetailModel> getReportDetail({
    @Path() required String id,
  });

  // @POST('/')
  // @Headers({
  //   'accessToken': 'true',
  // })
  // Future<ReportReqModel> postReport({
  //   @Body() required ReportReqModel researchReqModel,
  // });
}