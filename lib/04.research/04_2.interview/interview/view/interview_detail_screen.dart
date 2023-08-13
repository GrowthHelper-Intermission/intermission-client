// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intermission_project/04.research/04_2.interview/interview/component/interview_card.dart';
// import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_detail_model.dart';
// import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_model.dart';
// import 'package:intermission_project/04.research/04_2.interview/interview/provider/interview_provider.dart';
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
import 'package:intermission_project/04.research/04_2.interview/interview/provider/interview_provider.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/utils/pagination_utils.dart';
import 'package:intermission_project/common/view/default_layout.dart';

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
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(interviewProvider.notifier).getDetail(id: widget.id);
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
    final state = ref.watch(interviewDetailProvider(widget.id));

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      //구현 필요
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(state.mainTitle),
          Text(state.hourlyRate),
          Text(state.isOnline.toString()),
        ],
      ),
    );
  }
}
