import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/etc/friend_invite_screen.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/04.research/research/component/home_ongoing_research_list.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/setting/setting_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final TabController? tabController;

  HomeScreen({this.tabController});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final user = ref
    //     .watch(userMeProvider.notifier)
    //     .state! as UserModel; // 여기선 read, watch는 값 변경될때마다 빌드 ex(point)

    final userState = ref.watch(userMeProvider); // 상태를 읽어옴
    UserModel? user; // UserModel을 nullable로 선언

    if (userState is UserModel) {
      user = userState; // UserModel로 캐스팅
    }

    int point = 0;

    if (user == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Image.asset('assets/img/intermissionLogo.png',
                    width: 60, height: 38),
              ),
              SizedBox(width: 100),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // user.userNm,
                      user.userNm!,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${'1000'} P',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingScreen()),
                  );
                },
                icon:
                Image.asset('assets/img/Setting.png', width: 32, height: 32),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white12,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 350,
                  height: 84,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: SUB_COLOR,
                    ),
                    color: SUB_COLOR,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 18,
                            child: Text(
                              '[공지]',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9C5EDA),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            child: Text(
                              '투표 이미지 업로드 테스트를 시작해요~!',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Expanded(
                          child: Container(
                            height: 14,
                            child: Text(
                              '이미지 업로드 가이드 라인',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '진행 중인 인터뷰',
                        style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.tabController?.animateTo(3);
                        },
                        child: Text(
                          'More',
                          style: TextStyle(
                            color: SUB_BLUE_COLOR,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                OngoingResearchList(),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendInviteScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
                      child: Container(
                        width: 335,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: SUB_BLUE_COLOR,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '친구초대하고 300P받기',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: SUB_BLUE_COLOR,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
