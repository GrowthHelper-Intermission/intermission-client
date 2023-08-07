import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_screen.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/01.user/user/view/select_screen.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_detail_screen.dart';
import 'package:intermission_project/04.research/04_2.interview/interview_req/view/interview_req_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/common/view/splash_screen.dart';
import 'package:intermission_project/views/home/home_screen.dart';
import 'package:intermission_project/views/signup/signup_screen_page1.dart';
import 'package:intermission_project/views/signup/signup_screen_page2.dart';
import 'package:intermission_project/views/signup/signup_screen_page3.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(
      userMeProvider,
      (previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
          routes: [
            GoRoute(
              path: 'interview',
              name: InterviewScreen.routeName,
              builder: (_, state) => InterviewScreen(),
            ),
            GoRoute(
              path: 'interview/:rid',
              name: InterviewDetailScreen.routeName,
              builder: (_, state) =>
                  InterviewDetailScreen(id: state.pathParameters['rid']!),
              //restaurantScreen의 goNamed와 연결
            ),
          ],
        ),
        GoRoute(
          path: '/signup1',
          name: SignupScreenPage1.routeName,
          builder: (_, state) => SignupScreenPage1(),
          //restaurantScreen의 goNamed와 연결
        ),
        GoRoute(
          path: '/signup2',
          name: SignupScreenPage2.routeName,
          builder: (_, state) => SignupScreenPage2(),
          //restaurantScreen의 goNamed와 연결
        ),
        GoRoute(
          path: '/signup3',
          name: SignupScreenPage3.routeName,
          builder: (_, state) => SignupScreenPage3(),
          //restaurantScreen의 goNamed와 연결
        ),

        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
        GoRoute(
          path: '/select',
          name: SelectScreen.routeName,
          builder: (_, __) => SelectScreen(),
        ),

        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => LoginScreen(),
        ),
        GoRoute(
          path: '/request',
          name: InterviewReqScreen.routeName,
          builder: (_, __) => InterviewReqScreen(),
        ),
      ];

  logout() {
    ref.read(userMeProvider.notifier).logout();
    notifyListeners();
  }

  //SplashScreen
  //앱 처음 시작했을때 토큰 존재 확인하고
  //로그인 스크린으로 보내줄지 홈 스크린으로 보내줄지 확인 과정 필요
  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.path == '/login';

    //유저 정보 없는데 로그인중이면 그대로 로그인 페이지,
    // 만약 로그인중 아니면 로그인 페이지 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }
    //user != null
    //UserModel
    //사용자 정보가 있는 상태면(유저정보를 가져왔는데)
    //로그인중이거나 현재위치가 SplashScreen이면?
    //홈으로 이동('/'이게 홈임)
    if (user is UserModel) {
      return logginIn || state.uri.toString() == '/splash' ? '/' : '/select';
    }
    if (user is UserModelError) {
      return !logginIn ? '/login' : '/select';
    }

    return null;
  }
}
