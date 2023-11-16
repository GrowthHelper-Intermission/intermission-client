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
          Divider(color: Colors.grey[200], thickness: 10.0),
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
  final DateTime parsedDate = DateTime.parse(createdDate);
  final String formattedDate =
      '${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}';
  String displayEventType = '';
  switch (pointEventType) {
    case 'RECOMMENDATION':
      displayEventType = '추천인 이벤트 참여';
      break;
    case 'RESEARCH_PARTICIPATION':
      displayEventType = '리서치 참여';
      break;
  }

  String displayStatus = '';
  Color statusColor = Colors.black; // Default color

  switch (pointStatus) {
    case 'ACCUMULATED':
      displayStatus = '+$pointChangeBalance';
      statusColor = PRIMARY_COLOR;
      break;
    case 'USED':
      displayStatus = '$pointChangeBalance P';
      statusColor = Colors.red;
      break;
    case 'EXPIRED':
      displayStatus = '포인트 기한 만료';
      statusColor = SUB_BLUE_COLOR;
      break;
  }

  Widget? eventNameWidget;
  if (pointEventType == 'RESEARCH_PARTICIPATION' && pointEventName != null) {
    eventNameWidget = Text(
      pointEventName,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
    );
  }

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                    color: Colors.grey[500], fontWeight: FontWeight.w600),
              ),
              if (eventNameWidget != null) eventNameWidget,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayEventType,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    displayStatus,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${pointCurrentBalance} P',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Text(
              //   '${pointCurrentBalance}P',
              //   style: TextStyle(color: Colors.grey[600]),
              // ),
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
