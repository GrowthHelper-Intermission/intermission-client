// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intermission_project/04.research/04_2.interview/interview/component/interview_card.dart';
// import 'package:intermission_project/04.research/04_2.interview/interview/model/research_detail_model.dart';
// import 'package:intermission_project/04.research/04_2.interview/interview/model/research_model.dart';
// import 'package:intermission_project/04.research/04_2.interview/interview/provider/research_provider.dart';
// import 'package:intermission_project/common/const/colors.dart';
// import 'package:intermission_project/common/layout/default_layout.dart';
// import 'package:intermission_project/views/interview/home_interview_card.dart';
// import 'package:provider/provider.dart';
// import 'package:skeletons/skeletons.dart';
//
//
// class InterviewDetailScreen extends ConsumerStatefulWidget {
//   static String get routeName => 'interviewDetail';
//   final String id;
//   const InterviewDetailScreen({required this.id, super.key});
//
//   @override
//   ConsumerState<InterviewDetailScreen> createState() => _InterviewDetailScreenState();
// }
//
// class _InterviewDetailScreenState extends ConsumerState<InterviewDetailScreen> {
//   final ScrollController controller = ScrollController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ref.read(interviewProvider.notifier).getDetail(id: widget.id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(interviewDetailProvider(widget.id));
//     // final ratingsState = ref.watch(restaurantRatingProvider(widget.id));
//     // final basket = ref.watch(basketProvider); //badge를 위함
//
//     if (state == null) {
//       return DefaultLayout(
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     return DefaultLayout(
//       title: '인터뷰 모음',
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     //pushNamed와 goNamed의 차이
//       //     //goNamed는 뒤로가기버튼 X why? 얘만 stack
//       //     context.pushNamed(BasketScreen.routeName);
//       //   },
//       //   backgroundColor: PRIMARY_COLOR,
//       //   child: Badge(
//       //     showBadge: basket.isNotEmpty, //basket >= 1
//       //     badgeContent: Text(
//       //       basket
//       //           .fold<int>(0, (previous, next) => previous + next.count)
//       //           .toString(),
//       //       style: TextStyle(
//       //         color: PRIMARY_COLOR,
//       //         fontSize: 10,
//       //       ),
//       //     ),
//       //     badgeStyle: BadgeStyle(
//       //       badgeColor: Colors.white,
//       //     ),
//       //     child: Icon(
//       //       Icons.shopping_basket_outlined,
//       //     ),
//       //   ),
//       // ),
//       child: CustomScrollView(
//         controller: controller,
//         slivers: [
//           renderTop(
//             model: state,
//           ),
//           if (state is! InterviewDetailModel) renderLoading(),
//           if (state is InterviewModel) renderLabel(),
//           // if (state is InterviewDetailModel)
//           //   renderProducts(products: state.products, restaurant: state),
//
//           // if (ratingsState is CursorPagination<RatingModel>)
//           //   renderRatings(
//           //     models: ratingsState.data,
//           //   ),
//         ],
//       ),
//     );
//   }
//
//   // SliverPadding renderRatings({
//   //   required List<RatingModel> models,
//   // }) {
//   //   return SliverPadding(
//   //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//   //     sliver: SliverList(
//   //       delegate: SliverChildBuilderDelegate(
//   //             (_, index) => Padding(
//   //           padding: const EdgeInsets.only(bottom: 16),
//   //           child: RatingCard.fromModel(
//   //             model: models[index],
//   //           ),
//   //         ),
//   //         childCount: models.length,
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   SliverPadding renderLoading() {
//     return SliverPadding(
//       padding: EdgeInsets.symmetric(
//         vertical: 16.0,
//         horizontal: 16.0,
//       ),
//       sliver: SliverList(
//         delegate: SliverChildListDelegate(
//           List.generate(
//             3,
//                 (index) => Padding(
//               padding: const EdgeInsets.only(bottom: 32.0),
//               child: SkeletonParagraph(
//                 style: SkeletonParagraphStyle(
//                   lines: 5,
//                   padding: EdgeInsets.zero,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   SliverToBoxAdapter renderTop({
//     required InterviewModel model,
//   }) {
//     return SliverToBoxAdapter(
//       child: InterviewCard.fromModel(
//         model: model,
//       ),
//     );
//   }
//
//   SliverPadding renderLabel() {
//     return SliverPadding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       sliver: SliverToBoxAdapter(
//         child: Text(
//           '메뉴',
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 18,
//           ),
//         ),
//       ),
//     );
//   }
//
//   SliverPadding renderProducts({
//     required InterviewModel interview,
//     required List<RestaurantProductModel> products,
//   }) {
//     return SliverPadding(
//       padding: EdgeInsets.symmetric(horizontal: 16.0),
//       sliver: SliverList(
//         delegate: SliverChildBuilderDelegate(
//               (context, index) {
//             final model = products[index];
//
//             return InkWell(
//               onTap: () {
//                 ref.read(basketProvider.notifier).addToBasket(
//                     product: ProductModel(
//                       id: model.id,
//                       name: model.name,
//                       detail: model.detail,
//                       imgUrl: model.imgUrl,
//                       price: model.price,
//                       restaurant: restaurant,
//                     ));
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 16),
//                 child: InterviewCard.fromModel(model: model),
//               ),
//             );
//           },
//           childCount: products.length,
//         ),
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/component/interview_card.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/research_detail_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/research_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/provider/research_provider.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/utils/pagination_utils.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:skeletons/skeletons.dart';

class InterviewDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'interviewDetail';
  final String id;
  const InterviewDetailScreen({
    required this.id,
    super.key,
  });

  @override
  ConsumerState<InterviewDetailScreen> createState() =>
      _InterviewDetailScreenState();
}

class _InterviewDetailScreenState extends ConsumerState<InterviewDetailScreen> {
  // final ScrollController controller = ScrollController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(interviewProvider.notifier).getDetail(id: widget.id);
    ref.read(interviewInterviewProvider.notifier).getDetail(id: widget.id);
    ref.read(surveyProvider.notifier).getDetail(id: widget.id);
    ref.read(testerProvider.notifier).getDetail(id: widget.id);
  }

  // void listener() {
  //   //댓글로 수정
  //   PaginationUtils.paginate(
  //     controller: controller,
  //     provider: ref.read(restaurantRatingProvider(widget.id).notifier),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final interviewState = ref.watch(interviewDetailProvider(widget.id));
    //     final testerState = ref.watch(testerDetailProvider(widget.id));
    // final surveyState = ref.watch(surveyDetailProvider(widget.id));
    //
    // final interviewInterviewState = ref.watch(interviewInterviewDetailProvider(widget.id));


    //final state = testerState ?? surveyState ?? interviewState ?? interviewInterviewState;

    final state= interviewState;

    print('statre');

    if(state == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // if (state is! InterviewDetailModel) renderLoading();
    return Scaffold(

      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              context.go('/'); // 현재의 라우트를 1 단계 되돌립니다.
            },
          )),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Text(state.mainTitle),
            // Text(state.hourlyRate),
            // Text(state.isOnline.toString()),
            if (state is! ResearchModel) renderLoading(),
            //if (state is! InterviewDetailModel) renderLoading(),
            if (state is ResearchDetailModel)
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.researchType,
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(state.mainTitle),
                    Text(state.subTitle),
                    Text(state.exceptTime),
                    Text(state.isOnline),
                    Text(state.hourlyRate),
                    Text(state.dueDate),
                    Text(state.id),
                    Text(state.isOnGoing),
                    Text(state.detail),
                    Text(state.minAge),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
