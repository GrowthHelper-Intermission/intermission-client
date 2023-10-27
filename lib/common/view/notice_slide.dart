import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

class NoticeSlide extends StatefulWidget {
  @override
  _NoticeSlideState createState() => _NoticeSlideState();
}

class _NoticeSlideState extends State<NoticeSlide> {
  late PageController _pageController;
  int currentPage = 0;

  // 공지사항 예제 데이터
  List<String> notices = [
    '투표 이미지 업로드 테스트를 시작해요~!',
    '새로운 이벤트를 준비 중입니다!',
    '시스템 점검 안내입니다.',
  ];

  // 공지사항 별 색상 매핑
  Map<String, Color> noticeColors = {
    '투표 이미지 업로드 테스트를 시작해요~!': Colors.black,  // 예: PRIMARYCOLOR
    '새로운 이벤트를 준비 중입니다!': Colors.blue,
    '시스템 점검 안내입니다.': Colors.red,
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: SUB_COLOR,
        ),
        color: SUB_COLOR,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: PageView.builder(

        controller: _pageController,
        itemCount: notices.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnotherNoticeScreen(notices[index]),  // 공지사항 본문으로 이동
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '[공지]',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9C5EDA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    notices[index],
                    style: TextStyle(
                      fontSize: 15,
                      color: noticeColors[notices[index]] ?? Colors.black,  // 해당 공지사항의 색상 사용
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}



class AnotherNoticeScreen extends StatelessWidget {
  final String notice;

  AnotherNoticeScreen(this.notice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공지사항'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '[공지]',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              notice,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
