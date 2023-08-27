import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:intermission_project/01.user/user/provider/point_provider.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/view/default_layout.dart';

class PointCount extends ConsumerWidget {
  const PointCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pointProvider);

    if (state is CursorPagination<PointModel>) {
      final totalPoints = state.meta.totalPoint; // Meta에서 totalPoint 가져오기

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
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
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
                    date: model.createdAt,
                    reason: model.researchTitle,
                    pointChange: '+ ${model.pointAmount}P',
                    detailReason: model.researchType,
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      // 로딩이나 에러 상태 처리
      return CircularProgressIndicator();
    }
  }

  Widget _buildPointDetail({
    required String date,
    required String reason,
    required String pointChange,
    required String detailReason,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(color: Colors.grey[400]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reason),
                Text(pointChange),
              ],
            ),
            Text(
              detailReason,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

}
