import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/model/noti_req_model.dart';
import 'package:intermission_project/04.research/research/provider/noti_req_provider.dart';
import 'package:intermission_project/04.research/research/provider/notice_provider.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/provider/research_req_provider.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/home_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';

class NotiReqScreen extends ConsumerWidget {
  static String get routeName => 'notiRequest';
  const NotiReqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '공지 등록',
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              NotiReqModel newNoti = NotiReqModel(
                mainTitle: '[2023/09/01] 크레딧 모으는 방법을 알려드려요!',
                detail:
                    '인터미션은 인터뷰어와 인터뷰이를 매칭시켜주는 양방향 서비스 앱 플랫폼입니다!',

              );
              try {
                ref
                    .read(notiReqStateNotifierProvider.notifier)
                    .postReport(newNoti);
                print('Notice posted successfully');

                // Show the confirmation dialog
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("알림"),
                      content: Text("공지 등록되었습니다!"),
                      actions: [
                        TextButton(
                          child: Text("확인"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            ref.read(noticeProvider.notifier).paginate();
                            context.goNamed(RootTab
                                .routeName); // Navigate to the next screen
                          },
                        ),
                      ],
                    );
                  },
                );
              } catch (e) {
                print(e);
                print('Error occurred while posting research');
              }
            },
            child: Text('공지 등록'),
          ),
        ],
      ),
    );
  }
}
