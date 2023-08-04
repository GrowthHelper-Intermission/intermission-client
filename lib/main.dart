import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/models/interviews.dart';
import 'package:intermission_project/models/user.dart';
import 'package:intermission_project/views/interview/interviews.dart';
import 'package:intermission_project/common/view/intro_screen.dart';
import 'package:intermission_project/views/setting/setting_screen.dart';
import 'package:intermission_project/views/home/home_screen.dart';
import 'package:intermission_project/views/signup/signup_screen_page1.dart';
import 'package:intermission_project/views/signup/signup_screen_page2.dart';
import 'package:intermission_project/views/signup/signup_screen_page3.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //await uploadInterviews(interviews); // interviews 리스트를 파이어베이스에 업로드합니다.


  runApp(
      const MyApp()
  );
}

// Future<void> uploadInterviews(List<Map<String, dynamic>> interviews) async {
//   final CollectionReference interviewsCollection = FirebaseFirestore.instance.collection('interviews');
//
//   for (final interview in interviews) {
//     await interviewsCollection.add(interview);
//   }
// }


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<LoginUserProvider>(
//       create: (context) => LoginUserProvider(),
//       child: ScreenUtilInit(
//         //화면 사이즈
//         designSize: Size(375, 812),
//         builder: (context, _)
//         => MaterialApp(
//           theme: ThemeData(
//             fontFamily: 'Pretendard',
//           ),
//           //initialRoute: '/intro', //
//           routes: {
//             '/': (context) => IntroScreen(),
//             '/login' : (context) => LoginScreen(),
//             '/signup1' : (context) => SignupScreenPage1(),
//             '/signup2' : (context) => SignupScreenPage2(),
//             '/signup3' : (context) => SignupScreenPage3(),
//           },
//           debugShowCheckedModeBanner: false,
//           title: 'Your App Title',
//           // home: SignupScreenPage1(),
//           //home: SettingScreen(),
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginUserProvider()),
        // 다른 Provider를 추가하려면 아래와 같이 추가하면 됩니다.
        // ChangeNotifierProvider(create: (context) => SurveysProvider()),
        ChangeNotifierProvider(create: (context) => InterviewsProvider()),
        // ChangeNotifierProvider(create: (context) => ExperimentsProvider()),
        // ChangeNotifierProvider(create: (context) => UiTestsProvider()),
        // ChangeNotifierProvider(create: (context) => StatisticsProvider()),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, _) => MaterialApp(
          theme: ThemeData(
            fontFamily: 'Pretendard',
          ),
          routes: {
            '/': (context) => IntroScreen(),
            '/login' : (context) => LoginScreen(),
            '/signup1' : (context) => SignupScreenPage1(),
            '/signup2' : (context) => SignupScreenPage2(),
            '/signup3' : (context) => SignupScreenPage3(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Your App Title',
        ),
      ),
    );
  }
}
