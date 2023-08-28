import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/point/model/point_model.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:intermission_project/04.research/research/repository/research_repository.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'scrap_repository.g.dart';

//restaurantDetailProvider는 restaurantProvider를 watch하고 있기에
//restaurantProvider가 빌드되거나 상태가 변경되면
//restaurantDetailProvider도 마찬가지로 변경된다

//<RestaurantModel, String> 반환값은 왼쪽, 넣을건 id 오른쪽
final scrapRepositoryProvider = Provider<ScrapRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return ScrapRepository(dio, baseUrl: 'http://34.64.77.5:8080/api/scrap');
    // 'http://localhost:8080/api/interview'
  },
);



@RestApi()
abstract class ScrapRepository implements
    IBasePaginationRepository<ResearchModel> {
  factory ScrapRepository(Dio dio, {String baseUrl}) =
  _ScrapRepository;

  @GET('/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<ResearchModel>> paginate({
    @Path() String path = '/', // 기본값을 root path로 설정
    @Query('researchType') String? researchType,
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });


  @GET('/{id}') //Detailrestaurant용
  @Headers({
    'accessToken': 'true',
  })
  Future<ResearchDetailModel> getResearchDetail({
    @Path() required String id,
  });


  @POST('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<ParticipationResponse> scrapResearch({@Path() required String id});

}
