import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page1.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page2.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page3.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_screen.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/01.user/user/view/select_screen.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_detail_screen.dart';
import 'package:intermission_project/04.research/04_2.interview/interview_req/view/research_req_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/common/view/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    // 명심하자 -
    // /는 루트 경로로 인식된다
    //'interview' 아래에 ':rid'를 붙였을 때의 경로는 /interview/:rid 자동으로 /가 추가된다
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (_, __) => RootTab(),
      routes: [
        GoRoute(
          path: 'interview',
          name: InterviewScreen.routeName,
          builder: (_, state) => InterviewScreen(),
          routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
            GoRoute(
              path: ':id',
              name: InterviewDetailScreen.routeName,
              builder: (_, state) =>
                  InterviewDetailScreen(id: state.pathParameters['id']!),
            ),
          ],
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
      name: ResearchReqScreen.routeName,
      builder: (_, __) => ResearchReqScreen(),
    ),
  ];

  logout() {
    ref.read(userMeProvider.notifier).logout();
    notifyListeners();
  }

  //SplashScreen
  //앱 처음 시작했을때 토큰 존재 확인하고
  //로그인 스크린으로 보내줄지 홈 스크린으로 보내줄지 확인 과정 필요
  // FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
  //
  //   print('hello');
  //   final UserModelBase? user = ref.read(userMeProvider); //유저 상태를 가져온다
  //   final logginIn = state.matchedLocation == '/select';
  //   print(state.matchedLocation);
  //
  //   if (state.matchedLocation.startsWith('/signup')) {
  //     return null;  // 회원가입 중이므로 리다이렉트하지 않음
  //   }
  //
  //   // || state.matchedLocation == '/'
  //
  //   //유저 정보 없는데 로그인중이면 그대로 로그인 페이지,
  //   // 만약 로그인중 아니면 로그인 페이지 이동
  //   if (user == null) {
  //     return logginIn ? null : '/select';
  //   }
  //
  //   //user != null
  //   //UserModel
  //   //사용자 정보가 있는 상태면(유저정보를 가져왔는데)
  //   //로그인중이거나 현재위치가 SplashScreen이면?
  //   //홈으로 이동('/'이게 홈임)
  //   if (user is UserModel) {
  //     return logginIn || state.matchedLocation == '/splash' ||state.matchedLocation == '/login'  ? '/' : null;
  //   }
  //   if (user is UserModelError) {
  //     print('usermodelerror');
  //     return !logginIn ? '/select' : null;
  //   }
  //
  //   return null;
  // }

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    print('hello');
    final UserModelBase? user = ref.read(userMeProvider); //유저 상태를 가져온다
    final selecting = state.matchedLocation == '/select';
    final loggingIn = state.matchedLocation == '/login';
    print(state.matchedLocation);

    // 회원가입 중이면 리다이렉트하지 않음
    if (state.matchedLocation.startsWith('/signup')) {
      return null;
    }

    // 로그인 중이면서 사용자 정보가 있으면 홈으로 이동
    if (loggingIn && user is UserModel) {
      return '/';
    }

    // 로그인 중이 아니면서 사용자 정보가 없으면 /select 화면으로 이동
    if (!loggingIn && user == null) {
      return '/select';
    }

    // // SplashScreen이나 로그인 중이면서 사용자 정보가 있으면 홈으로 이동
    // if ((selecting || state.matchedLocation == '/splash') && user is UserModel) {
    //   return '/';
    // }

    if (user is UserModel) {
      return (selecting || loggingIn || state.matchedLocation == '/splash') ? '/' : null;
    }

    // 사용자 정보가 없으면 /select 화면으로 이동
    if (user == null) {
      return '/select';
    }

    // 에러 발생 시 /select 화면으로 이동
    if (user is UserModelError) {
      print('usermodelerror');
      return '/select';
    }

    return null;
  }


}