import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/view/report_detail_screen.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page1.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page2.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page3.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/01.user/user/view/select_screen.dart';
import 'package:intermission_project/01.user/user/view/user_report_screen.dart';
import 'package:intermission_project/04.research/research/view/notice_detail_screen.dart';
import 'package:intermission_project/04.research/research/view/notice_req_screen.dart';
import 'package:intermission_project/04.research/research/view/notice_screen.dart';
import 'package:intermission_project/04.research/research/view/research_detail_screen.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/view/research_req_screen.dart';
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
          path: 'research',
          name: ResearchScreen.routeName,
          builder: (_, state) => ResearchScreen(),
          routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
            GoRoute(
              path: ':id',
              name: ResearchDetailScreen.routeName,
              builder: (_, state) =>
                  ResearchDetailScreen(id: state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: 'noti',
          name: NoticeScreen.routeName,
          builder: (_, state) => NoticeScreen(),
          routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
            GoRoute(
              path: ':id',
              name: NoticeDetailScreen.routeName,
              builder: (_, state) =>
                  NoticeDetailScreen(id: state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: 'report',
          name: UserReportScreen.routeName,
          builder: (_, state) => UserReportScreen(),
          routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
            GoRoute(
              path: ':id',
              name: ReportDetailScreen.routeName,
              builder: (_, state) =>
                  ReportDetailScreen(id: state.pathParameters['id']!),
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
    GoRoute(
      path: '/notiRequest',
      name: NotiReqScreen.routeName,
      builder: (_, __) => NotiReqScreen(),
    ),
  ];

  logout() {
    ref.read(userMeProvider.notifier).logout();
    notifyListeners();
  }

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    // 회원가입 페이지에서 회원가입 완료 후 로그인 페이지로 리다이렉트
    if (state.matchedLocation == '/signup' && user is UserModel) return '/';

    if (state.matchedLocation.startsWith('/signup')) return null;

    if (state.matchedLocation == '/login' && user is UserModel) return '/';

    if (!state.matchedLocation.startsWith('/login') && user == null) return '/select';

    if (user is UserModel &&
        (state.matchedLocation == '/select'
            || state.matchedLocation == '/login' ||
            state.matchedLocation == '/splash')) return '/';

    // if (user is UserModelError) return '/select';

    return null;
  }

  // FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
  //   final UserModelBase? user = ref.read(userMeProvider);
  //
  //   // 로그인 페이지나 회원가입 페이지에 있고, 사용자가 이미 로그인했다면 메인 화면으로 리다이렉트
  //   if ((state.matchedLocation.startsWith('/signup') || state.matchedLocation == '/login') && user is UserModel) {
  //     return '/';
  //   }
  //
  //   // 메인 화면('/')에 있거나 로그인/회원가입 관련 페이지에 있으면 아무 것도 하지 않음
  //   if (state.matchedLocation == '/' || state.matchedLocation.startsWith('/signup') || state.matchedLocation == '/login') {
  //     return null;
  //   }
  //
  //   // 로그인하지 않은 상태이고, 로그인/회원가입 페이지가 아니라면 /select로 리다이렉트
  //   if (user == null) {
  //     return '/select';
  //   }
  //
  //   return null;
  // }

}