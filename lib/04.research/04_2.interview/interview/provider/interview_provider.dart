import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_detail_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/repository/interview_repository.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

//캐시 공유 시작
//restaurantDetailProvider는 restaurantProvider를 watch하고 있기에
//restaurantProvider가 빌드되거나 상태가 변경되면
//restaurantDetailProvider도 마찬가지로 변경된다

//<RestaurantModel, String> 반환값은 왼쪽, 넣을건 id 오른쪽

final interviewDetailProvider =
Provider.family<InterviewModel?, String>((ref, id) {
  final state = ref.watch(interviewProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final interviewProvider =
StateNotifierProvider<InterviewStateNotifier, CursorPaginationBase>(
      (ref) {
    final repository = ref.watch(interviewRepositoryProvider);
    final notifier = InterviewStateNotifier(repository: repository);
    return notifier;
  },
);

class InterviewStateNotifier
    extends PaginationProvider<InterviewModel, InterviewRepository> {
  // final RestaurantRepository repository;

  InterviewStateNotifier({
    required super.repository,
  });

  getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면? (CursorPagination 아니라면)
    // 데이터를 가져오는 시도를 한다
    if (state is! CursorPagination) {
      await this.paginate();
    }

    //state가 CursorPagination이 아닐때는 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    //응답으로 받은 restaurantDetailModel
    final resp = await repository.getInterviewDetail(id: id);

    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
    // 요청 id: 10
    // list.where((e) => e.id == 10)) 데이터 X
    // 데이터가 없을때는 그냥 캐시의 끝에다가 데이터를 추가해버린다
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)],
    // RestaurantDetailModel(10)
    if(pState.data.where((e) => e.id == id).isEmpty){
      state = pState.copyWith(
        data: <InterviewModel>[
          ...pState.data,
          resp,
        ],
      );
    }else{
      state = pState.copyWith(
        data: pState.data
            .map<InterviewModel>(
              (e) => e.id == id ? resp : e,
        )
            .toList(),
      );
    }

    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
    // id : 2인 친구를 Detail모델을 가져와라
    // getDetail(id: 2);
    // [RestaurantModel(1), RestaurantDetailModel(2), RestaurantModel(3)]

  }
}