import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:intermission_project/01.user/user/provider/point_provider.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:skeletons/skeletons.dart';

class PointCount extends ConsumerWidget {
  const PointCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pointProvider);

    // 데이터가 없거나 로딩 중인 경우
    if (state is CursorPaginationLoading || state == null) {
      return Scaffold(body: renderLoading());
    }

    int totalPoints = 0; // Default value
    if (state is CursorPagination<PointModel>) {
      totalPoints = state.meta.pointAmount!; // Meta에서 totalPoint 가져오기
    }

    return DefaultLayout(
      title: '포인트 적립 내역',
      child: Column(
        children: [
          Container(
            width: 360,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.grey.shade200,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '나의 포인트',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Text(
                    '$totalPoints P',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // 간격 조정
          Divider(color: Colors.grey[200], thickness: 12.0),
          Expanded(
            child: PaginationListView<PointModel>(
              provider: pointProvider,
              itemBuilder: <PointModel>(context, index, model) {
                return _buildPointDetail(
                  pointStatus: model.pointStatus,
                  pointChangeBalance: model.pointChangeBalance.toString(),
                  pointCurrentBalance: model.pointCurrentBalance.toString(),
                  pointPreviousBalance: model.pointPreviousBalance.toString(),
                  pointEventType: model.pointEventType,
                  createdDate: model.createdDate,
                  expireTime: model.expireTime,
                  pointEventName: model.pointEventName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPointDetail({
  required String pointStatus,
  required String pointChangeBalance,
  required String pointCurrentBalance,
  required String pointPreviousBalance,
  required String pointEventType,
  required String createdDate,
  required String expireTime,
  String? pointEventName,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                createdDate,
                style: TextStyle(color: Colors.grey[400]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pointEventType),
                  Text(pointStatus),
                ],
              ),
              Text(
                pointCurrentBalance,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
      Divider(color: Colors.grey[300], thickness: 0.5), // 구분선 추가
    ],
  );
}


// 로딩 위젯을 Sliver가 아닌 일반 Padding 위젯으로 변경
Widget renderLoading() {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 16.0,
    ),
    child: Column(
      children: List.generate(
        3,
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
  );
}
