import 'package:dio/dio.dart';
import 'package:intermission_project/04.research/04_2.interview/interview_req/model/research_req_model.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'research_req_repository.g.dart';


final researchReqRepositoryProvider = Provider<ResearchReqRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    // return UserMeRepository(dio,baseUrl: 'http://$ip/user/me');
    // 'http://localhost:8080/api/user/save'
    return ResearchReqRepository(dio, baseUrl: 'http://34.64.77.5:8080/api/v1/test/research');
  },
);

@RestApi()
abstract class ResearchReqRepository{
  factory ResearchReqRepository(Dio dio, {String baseUrl}) = _ResearchReqRepository;
  
  @POST('/')
  Future<ResearchReqModel> postResearch(@Body() ResearchReqModel researchReqModel);

}


// @RestApi()
// abstract class InterviewRepository implements
//     IBasePaginationRepository<ResearchModel> {
//   factory InterviewRepository(Dio dio, {String baseUrl}) =
//   _InterviewRepository;
//
//
//   // http://34.64.77.5:8080/api/v1/test/interview/interview?researchType=1
//   @GET('/')
//   Future<CursorPagination<ResearchModel>> paginate({
//     @Query('researchType') String? researchType,
//     @Queries() PaginationParams? paginationParams = const PaginationParams(),
//   });
//
//   // http://34.64.77.5:8080/api/v1/test/interview
//   // 'http://$ip/restaurant/:id'
//   @GET('/{id}') //Detailrestaurant용
//
//   //@Headers는 강제 삽입
//   // @Headers({
//   //   'accessToken': 'true',
//   // })
//   Future<ResearchDetailModel> getResearchDetail({
//     @Path() required String id,
//   });
// }
