import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/model/comment_model.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:intermission_project/04.research/research/model/single_comment.dart';
import 'package:intermission_project/04.research/research/repository/research_repository.dart';
import 'package:intermission_project/04.research/research/repository/scrap_repository.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/model/post_response.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'comment_repository.g.dart';

//restaurantDetailProvider는 restaurantProvider를 watch하고 있기에
//restaurantProvider가 빌드되거나 상태가 변경되면
//restaurantDetailProvider도 마찬가지로 변경된다

//<RestaurantModel, String> 반환값은 왼쪽, 넣을건 id 오른쪽
final commentRepositoryProvider = Provider<CommentRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return CommentRepository(dio, baseUrl: 'https://$ip/api/comment');
    // 'http://localhost:8080/api/interview'
  },
);

@RestApi()
abstract class CommentRepository {
  factory CommentRepository(Dio dio, {String baseUrl}) = _CommentRepository;

  ///댓글 등록 하기
  @POST('/{researchId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<String> postComment(
    @Path('researchId') String researchId,
    @Body() SingleComment comment,
  );

  ///댓글 삭제 하기
  @DELETE('/{commentId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<PostResponse> deleteComment(@Path('commentId') String commentId);

  ///대댓글 등록 하기
  @POST('/{researchId}/{recommentId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<PostResponse> postReComment(
    @Path('researchId') String researchId,
    @Path('recommentId') String commentId,
    @Body() SingleComment reComment,
  );

  /// 댓글 신고 하기
  @POST('/report/{commentId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<PostResponse> reportComment(@Path('commentId') String commentId);

  // ///대댓글 수정 하기
  // @PATCH('/{researchId}/{recommentId}')
  // Future<String> updateReComment(
  //     @Path('recommentId') String recommentId,
  //     @Body() SingleComment updatedComment,
  //     );

  // ///대댓글 삭제 하기
  // @DELETE('/{researchId}/{recommentId}')
  // @Headers({
  //   'accessToken': 'true',
  // })
  // Future<String> deleteReComment(
  //     @Path('researchId') String researchId,
  //     @Path('recommentId') String recommentId,
  //     );
  // // Future<String> deleteReComment(@Path('recommentId') String recommentId);

// ///댓글 수정 하기
// @PATCH('/{commentId}')
// @Headers({
//   'accessToken': 'true',
// })
// Future<String> updateComment(
//     @Path('commentId') String commentId,
//     @Body() SingleComment updatedComment,
//     );
}
