import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_detail_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/provider/interview_provider.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'interview_repository.g.dart';

//restaurantDetailProvider는 restaurantProvider를 watch하고 있기에
//restaurantProvider가 빌드되거나 상태가 변경되면
//restaurantDetailProvider도 마찬가지로 변경된다

//<RestaurantModel, String> 반환값은 왼쪽, 넣을건 id 오른쪽
final interviewRepositoryProvider = Provider<InterviewRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
        return InterviewRepository(dio, baseUrl: 'http://localhost:8080/api/interview');
  },
);

@RestApi()
abstract class InterviewRepository implements
    IBasePaginationRepository<InterviewModel> {
  factory InterviewRepository(Dio dio, {String baseUrl}) =
  _InterviewRepository;

  @GET('/') //일반 인터뷰
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<InterviewModel>> paginate({
    //retrofit에서 쿼리 추가할때
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });


  // http://34.64.77.5:8080/api/v1/test/interview
  // 'http://$ip/restaurant/:id'
  @GET('/{id}') //Detailrestaurant용
  //@Headers는 강제 삽입
  @Headers({
    'accessToken': 'true',
  })
  Future<InterviewDetailModel> getInterviewDetail({
    @Path() required String id,
  });
}
