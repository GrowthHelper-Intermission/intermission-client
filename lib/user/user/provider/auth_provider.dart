import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/certification/certification_result.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/common/view/select_screen.dart';
import 'package:intermission_project/notice/notice_detail_screen.dart';
import 'package:intermission_project/notice/notice_req_screen.dart';
import 'package:intermission_project/notice/notice_screen.dart';
import 'package:intermission_project/04.research/research/view/research_detail_screen.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/view/research_req_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/common/view/splash_screen.dart';
import 'package:intermission_project/user/user/model/user_model.dart';
import 'package:intermission_project/user/user/provider/user_me_provider.dart';
import 'package:intermission_project/user/user/view/login_screen.dart';
import 'package:intermission_project/user/user/view/report_detail_screen.dart';
import 'package:intermission_project/user/user/view/signup_screen_page1.dart';
import 'package:intermission_project/user/user/view/signup_screen_page2.dart';
import 'package:intermission_project/user/user/view/signup_screen_page3.dart';
import 'package:intermission_project/user/user/view/user_partcipated_research_screen.dart';
import 'package:intermission_project/user/user/view/user_report_screen.dart';
import 'package:intermission_project/user/user/view/user_scrap_interview_screen.dart';
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
          builder: (_, __) => const RootTab(),
          routes: [
            GoRoute(
              path: 'research',
              name: ResearchScreen.routeName,
              builder: (_, state) => ResearchScreen(),
              routes: [
                // InterviewScreen 아래에 nested route로 DetailScreen 설정
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
              routes: [
                // InterviewScreen 아래에 nested route로 DetailScreen 설정
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
              routes: [
                // InterviewScreen 아래에 nested route로 DetailScreen 설정
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
        GoRoute(
          path: '/scrap',
          name: ScrapedResearchScreen.routeName,
          builder: (_, __) => ScrapedResearchScreen(),
        ),
        GoRoute(
          path: '/participated',
          name: ParticipatedResearchScreen.routeName,
          builder: (_, __) => ParticipatedResearchScreen(),
        ),
    GoRoute(
      path: '/certification-result',
      name: CertificationResult.routeName,
      builder: (_, __) => CertificationResult(),
    ),
      ];

  logout() {
    ref.read(userMeProvider.notifier).logout();
    notifyListeners();
  }

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    if (state.matchedLocation == '/certification-result' && user is UserModel) return '/';
    // 회원가입 페이지에서 회원가입 완료 후 로그인 페이지로 리다이렉트
    if (state.matchedLocation == '/signup' && user is UserModel) return '/';

    if (state.matchedLocation.startsWith('/signup')) return null;

    if (state.matchedLocation == '/login' && user is UserModel) return '/';


    if (!state.matchedLocation.startsWith('/login') && user == null) {
      return '/select';
    }

    if (user is UserModel &&
        (state.matchedLocation == '/select' ||
            state.matchedLocation == '/login' ||
            state.matchedLocation == '/splash')) return '/';

    return null;
  }
}
