import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intermission_project/common/component/main_tab_controller.dart';
import 'package:intermission_project/models/user.dart';
import 'package:intermission_project/views/intro_screen.dart';
import 'package:intermission_project/views/setting/setting_screen.dart';
import 'package:intermission_project/views/home/home_body_section.dart';
import 'package:intermission_project/views/login/login_screen.dart';
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
  runApp(
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginUserProvider>(
      create: (context) => LoginUserProvider(),
      child: ScreenUtilInit(
        //화면 사이즈
        designSize: Size(375, 812),
        builder: (context, _)
        => MaterialApp(
          theme: ThemeData(
            fontFamily: 'Pretendard',
          ),
          //initialRoute: '/intro', //
          routes: {
            '/': (context) => IntroScreen(),
            '/login' : (context) => LoginScreen(),
            '/signup1' : (context) => SignupScreenPage1(),
            '/signup2' : (context) => SignupScreenPage2(),
            '/signup3' : (context) => SignupScreenPage3(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Your App Title',
          // home: SignupScreenPage1(),
          //home: SettingScreen(),
        ),
      ),
    );
  }

}
