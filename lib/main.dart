// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/01.user/user/view/certification.dart';
import 'package:intermission_project/01.user/user/view/certification_result.dart';
import 'package:intermission_project/01.user/user/view/certification_test.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/01.user/user/view/report_detail_screen.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page1.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page2.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page3.dart';
import 'package:intermission_project/01.user/user/view/user_report_screen.dart';
import 'package:intermission_project/04.research/research/view/notice_detail_screen.dart';
import 'package:intermission_project/04.research/research/view/notice_req_screen.dart';
import 'package:intermission_project/04.research/research/view/notice_screen.dart';
import 'package:intermission_project/04.research/research/view/research_detail_screen.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/view/research_req_screen.dart';
import 'package:intermission_project/common/provider/go_router.dart';
import 'package:intermission_project/common/view/home.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/common/view/select_screen.dart';
import 'package:intermission_project/common/view/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 다언어 설정

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routeProvider);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) =>
          MaterialApp.router(
            theme: ThemeData(
              fontFamily: 'Pretendard',
            ),
            debugShowCheckedModeBanner: false,
            routerConfig: route,
            localizationsDelegates: const [ // 다언어 설정
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''), // English
              const Locale('ko', ''), // Korean
            ],
          ),
    );
  }

// @override
// Widget build(BuildContext context, WidgetRef ref) {
//   // 라우트 로직을 여기에 추가할 수 있습니다.
//   return ScreenUtilInit(
//     designSize: Size(375, 812),
//     builder: (context, child) => MaterialApp(
//       theme: ThemeData(
//         fontFamily: 'Pretendard',
//       ),
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: (RouteSettings settings) {
//         // 라우트 이름에 따라 다른 페이지로 라우트합니다.
//         switch (settings.name) {
//           case '/':
//             return MaterialPageRoute(builder: (context) => Home()); // 예시 페이지
//           case '/certification-result':
//           // 인수를 받아서 다른 페이지로 전달할 수 있습니다.
//             final result = settings.arguments as Map<String, String>;
//             return MaterialPageRoute(builder: (context) => CertificationResult()); // 예시 페이지
//           // default:
//           //   return MaterialPageRoute(builder: (context) => NotFoundPage()); // 예시 페이지
//         }
//       },
//       localizationsDelegates: const [  // 다언어 설정
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: [
//         const Locale('en', ''), // English
//         const Locale('ko', ''), // Korean
//       ],
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       builder: (context, child) => GetMaterialApp(
//         initialRoute: '/',
//         theme: ThemeData(
//           fontFamily: 'Pretendard',
//         ),
//         debugShowCheckedModeBanner: false,
//         getPages: [
//           GetPage(
//             name: '/',
//             page: () => RootTab(),
//           ),
//           GetPage(name: '/splash', page: () => SplashScreen()),
//           GetPage(
//             name: '/test-home',
//             page: () => Home(),
//             middlewares: [AuthMiddleware()], // 인증 상태를 체크하는 Middleware 추가
//           ),
//           GetPage(name: '/certification-test', page: () => CertificationTest()),
//           GetPage(name: '/certification', page: () => Certification()),
//           GetPage(
//               name: '/certification-result', page: () => CertificationResult()),
//           GetPage(name: '/research', page: () => ResearchScreen()),
//           GetPage(
//             name: '/research/:id',
//             page: () => ResearchDetailScreen(id: Get.parameters['id']!),
//           ),
//           GetPage(name: '/noti', page: () => NoticeScreen()),
//           GetPage(
//             name: '/noti/:id',
//             page: () => NoticeDetailScreen(id: Get.parameters['id']!),
//           ),
//           GetPage(
//             name: '/report',
//             page: () => UserReportScreen(),
//           ),
//           GetPage(
//             name: '/report/:id',
//             page: () => ReportDetailScreen(id: Get.parameters['id']!),
//           ),
//           GetPage(name: '/signup1', page: () => SignupScreenPage1()),
//           GetPage(name: '/signup2', page: () => SignupScreenPage2()),
//           GetPage(name: '/signup3', page: () => SignupScreenPage3()),
//           GetPage(name: '/select', page: () => SelectScreen()),
//           GetPage(name: '/login', page: () => LoginScreen()),
//           GetPage(name: '/request', page: () => ResearchReqScreen()),
//           GetPage(name: '/notiRequest', page: () => NotiReqScreen()),
//         ],
//         localizationsDelegates: const [
//           // 다언어 설정
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         supportedLocales: [
//           const Locale('en', ''), // English
//           const Locale('ko', ''), // Korean
//         ],
//       ),
//     );
//   }
// }

// class AuthController extends GetxController {
//   var isUserAuthenticated = false.obs; // 예: 인증 상태를 저장하는 변수
//
//   void updateAuthStatus(bool status) {
//     isUserAuthenticated.value = status;
//   }
// }
//
// class AuthMiddleware extends GetMiddleware {
//   @override
//   redirect(String? route) {
//     var authController = Get.find<AuthController>();
//
//     if (route == '/signup' && authController.isUserAuthenticated.value)
//       return RouteSettings(name: '/');
//
//     if (route?.startsWith('/signup') ?? false) return null;
//
//     if (route == '/login' && authController.isUserAuthenticated.value)
//       return RouteSettings(name: '/');
//
//     // 여기에 추가적인 리다이렉션 로직을 넣을 수 있음
//
//     return null; // 인증되었다면 현재 라우트로 진행
//   }
// }

// class AuthMiddleware extends GetMiddleware {
//   @override
//   redirect(String? route) {
//     var authController = Get.find<AuthController>();
//     final UserModelBase? user = ref.read(userMeProvider);
//
//     // 예시: 인증된 사용자만 '/certification-result'에 접근할 수 있게 함
//     if (route == '/certification-result' && !authController.isUserAuthenticated.value) {
//       return RouteSettings(name: '/login');  // 인증되지 않았다면 로그인 페이지로 리다이렉트
//     }
//
//     // 여기에 추가적인 리다이렉션 로직을 넣을 수 있음
//
//     return null;  // 인증되었다면 현재 라우트로 진행
//   }
// }

// class AuthMiddleware extends GetMiddleware {
//   @override
//   redirect(String? route) {
//     var authController = Get.find<AuthController>();
//     if (!authController.isUserAuthenticated.value) {
//       return RouteSettings(name: '/login');  // 인증되지 않았다면 로그인 페이지로 리다이렉트
//     }
//     return null;  // 인증되었다면 현재 라우트로 진행
//   }
  }

