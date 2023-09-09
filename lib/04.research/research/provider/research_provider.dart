import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:intermission_project/04.research/research/model/research_report_model.dart';
import 'package:intermission_project/04.research/research/repository/research_repository.dart';
import 'package:intermission_project/common/model/content_model.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/post_response.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

final interviewProvider = StateNotifierProvider<ResearchStateNotifier, CursorPaginationBase>(
      (ref) {
    final repository = ref.watch(researchRepositoryProvider);
    final notifier = ResearchStateNotifier(repository: repository,researchType: "interview");
    return notifier;
  },
);


final surveyProvider = StateNotifierProvider<ResearchStateNotifier, CursorPaginationBase>(
      (ref) {
    final repository = ref.watch(researchRepositoryProvider);
    final notifier = ResearchStateNotifier(repository: repository,researchType: "survey");
    return notifier;
  },
);

final testerProvider = StateNotifierProvider<ResearchStateNotifier, CursorPaginationBase>(
      (ref) {
    final repository = ref.watch(researchRepositoryProvider);
    final notifier = ResearchStateNotifier(repository: repository,researchType: "test");
    return notifier;
  },
);

final researchProvider =
StateNotifierProvider<ResearchStateNotifier, CursorPaginationBase>(
      (ref) {
    final repository = ref.watch(researchRepositoryProvider);
    final notifier = ResearchStateNotifier(repository: repository,researchType: null);
    return notifier;
  },
);

final researchDetailProvider =
    Provider.family<ResearchModel?, String>((ref, id) {
  final state = ref.watch(researchProvider);

  if (state is! CursorPagination) {
    return null;
  }
  return state.data.firstWhereOrNull((element) => element.id == id);
});



class ResearchStateNotifier
    extends PaginationProvider<ResearchModel, ResearchRepository> {
  // final RestaurantRepository repository;

  final String? researchType;

  ResearchStateNotifier({
    required super.repository,
    this.researchType,
  }): super(autoFetch: false) {
    // 클래스가 초기화될 때 researchType을 출력!
    paginate(researchType: researchType);
    // print("Research Type: $researchType");
  }

  Future<ParticipationResponse> participateInResearch({required String id}) async {
    return await repository.participateResearch(id: id);
  }

  Future<PostResponse>reportResearchNow({required String id, required String content}) async{
    return await repository.reportResearch(id: id, content: ContentModel(content: content).toJson());
  }



  // 상위 3개의 인터뷰를 가져오는 함수
  List<ResearchModel> getTopThreeResearches() {
    if (state is! CursorPagination) {
      return [];
    }
    final pState = state as CursorPagination;

    // 인터뷰 개수가 3개 이상인 경우 상위 3개를 가져오고, 그렇지 않으면 모든 인터뷰를 가져오기
    int count = (pState.data.length > 3) ? 3 : pState.data.length;

    // 데이터 타입 변환
    List<ResearchModel> topThreeList = List<ResearchModel>.from(
      pState.data.sublist(0, count),
    );
    return topThreeList;
  }


  getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면? (CursorPagination 아니라면)
    // 데이터를 가져오는 시도를 한다
    if (state is! CursorPagination) {
      if (researchType == null) {
        await paginate();
      } else {
        await paginate(researchType: researchType!);
      }
    }

    //state가 CursorPagination이 아닐때는 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    //응답으로 받은 restaurantDetailModel
    final resp = await repository.getResearchDetail(id: id);

    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
    // 요청 id: 10
    // list.where((e) => e.id == 10)) 데이터 X
    // 데이터가 없을때는 그냥 캐시의 끝에다가 데이터를 추가해버린다
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)],
    // RestaurantDetailModel(10)
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <ResearchModel>[
          ...pState.data,
          resp,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<ResearchModel>(
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



