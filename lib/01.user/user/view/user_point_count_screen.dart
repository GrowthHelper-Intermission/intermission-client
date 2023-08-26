import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/default_layout.dart';

class PointCount extends StatelessWidget {
  const PointCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    '10P',
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
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '포인트 내역',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                _buildPointDetail(
                  date: '2022.07.24',
                  reason: '청년 마인드 케어를 위한 고민 조사',
                  pointChange: '+ 10P',
                  detailReason: '리서치 참여',
                ),
                _buildPointDetail(
                  date: '2022.07.24',
                  reason: '청년 마인드 케어를 위한 고민 조사',
                  pointChange: '+ 10P',
                  detailReason: '리서치 참여',
                ),
                _buildPointDetail(
                  date: '2022.07.24',
                  reason: '청년 마인드 케어를 위한 고민 조사',
                  pointChange: '+ 10P',
                  detailReason: '리서치 참여',
                ),
                _buildPointDetail(
                  date: '2022.07.24',
                  reason: '청년 마인드 케어를 위한 고민 조사',
                  pointChange: '+ 10P',
                  detailReason: '리서치 참여',
                ),
                Divider(color: Colors.grey[200], thickness: 1.0),
              ],
            ),
          )
        ],
      ),
    );
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
