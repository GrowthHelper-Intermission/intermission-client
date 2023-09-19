import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/point/model/point_model.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:intermission_project/04.research/research/model/research_report_model.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/model/post_response.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'research_repository.g.dart';

//restaurantDetailProvider는 restaurantProvider를 watch하고 있기에
//restaurantProvider가 빌드되거나 상태가 변경되면
//restaurantDetailProvider도 마찬가지로 변경된다

//<RestaurantModel, String> 반환값은 왼쪽, 넣을건 id 오른쪽
final researchRepositoryProvider = Provider<ResearchRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return ResearchRepository(dio, baseUrl: 'http://$ip/api/research');
    // 'http://localhost:8080/api/interview'
  },
);



@RestApi()
abstract class ResearchRepository implements
    IBasePaginationRepository<ResearchModel> {
  factory ResearchRepository(Dio dio, {String baseUrl}) =
  _ResearchRepository;


  @GET('{path}')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<ResearchModel>> paginate({
    @Path() String path = '/', // 기본값을 root path로 설정
    @Query('researchType') String? researchType,
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // @GET('/me')
  // @Headers({
  //   'accessToken': 'true',
  // })
  // Future<CursorPagination<ResearchModel>> paginate({
  //   @Path() String path = '/', // 기본값을 root path로 설정
  //   @Query('researchType') String? researchType,
  //   @Queries() PaginationParams? paginationParams = const PaginationParams(),
  // });

  // http://34.64.77.5:8080/api/v1/test/interview
  // 'http://$ip/restaurant/:id'
  @GET('/{id}') //Detailrestaurant용
  @Headers({
    'accessToken': 'true',
  })
  Future<ResearchDetailModel> getResearchDetail({
    @Path() required String id,
  });

//리서치 참여하기
  @PATCH('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<ParticipationResponse> participateResearch({@Path() required String id});


  //리서치 신고하기
  @POST('/report/{id}')
  @Headers({
    'accessToken': 'true'
  })
  Future<PostResponse> reportResearch({@Path() required String id, @Body() required Map<String, dynamic> content});

}


class ParticipationResponse {
  final String isJoin;

  ParticipationResponse({required this.isJoin});

  factory ParticipationResponse.fromJson(Map<String, dynamic> json) {
    return ParticipationResponse(isJoin: json['isJoin']);
  }
}