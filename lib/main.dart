// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intermission_project/01.user/user/view/certification.dart';
import 'package:intermission_project/01.user/user/view/certification_result.dart';
import 'package:intermission_project/01.user/user/view/certification_test.dart';
import 'package:intermission_project/common/provider/go_router.dart';
import 'package:intermission_project/common/view/home.dart';
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


  // Widget build(BuildContext context, WidgetRef ref) {
  //   final route = ref.watch(routeProvider);
  //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     systemNavigationBarColor: Colors.transparent,
  //     statusBarColor: Colors.transparent,
  //   ));
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //
  //   return ScreenUtilInit(
  //     designSize: Size(375, 812),
  //     builder: (context, child) => MaterialApp.router(
  //       theme: ThemeData(
  //         fontFamily: 'Pretendard',
  //       ),
  //       debugShowCheckedModeBanner: false,
  //       routerConfig: route,
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
  //             return MaterialPageRoute(builder: (context) => CertificationResult(result: result,)); // 예시 페이지
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 라우트 로직을 여기에 추가할 수 있습니다.
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        initialRoute: '/',
        theme: ThemeData(
          fontFamily: 'Pretendard',
        ),
        debugShowCheckedModeBanner: false,
        // onGenerateRoute: (RouteSettings settings) {
        //   // 라우트 이름에 따라 다른 페이지로 라우트합니다.
        //   switch (settings.name) {
        //     case '/':
        //       return MaterialPageRoute(builder: (context) => Home()); // 예시 페이지
        //     case '/certification-result':
        //     // 인수를 받아서 다른 페이지로 전달할 수 있습니다.
        //       final result = settings.arguments as Map<String, String>;
        //       return MaterialPageRoute(builder: (context) => CertificationResult(result: result,)); // 예시 페이지
        //   // default:
        //   //   return MaterialPageRoute(builder: (context) => NotFoundPage()); // 예시 페이지
        //   }
        // },
        getPages: [
          // GetPage(name: '/main', page:() => MainTestScreen()),
          GetPage(name: '/', page: () => Home()),
          // GetPage(name: '/payment-test', page: () => PaymentTest()),
          // GetPage(name: '/payment', page: () => Payment()),
          // GetPage(name: '/payment-result', page: () => PaymentResult()),
          GetPage(name: '/certification-test', page: () => CertificationTest()),
          GetPage(name: '/certification', page: () => Certification()),
          GetPage(
              name: '/certification-result', page: () => CertificationResult()),
        ],
        localizationsDelegates: const [  // 다언어 설정
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
}
