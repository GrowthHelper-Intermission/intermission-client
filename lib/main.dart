import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intermission_project/common/component/tabbar_using_controller.dart';
import 'package:intermission_project/counter.dart';
import 'package:intermission_project/views/home/home_main_screen.dart';
import 'package:intermission_project/views/login/login_screen.dart';
import 'package:intermission_project/views/signup/signup_screen_page1.dart';
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
    return ScreenUtilInit(
      //화면 사이즈
      designSize: Size(375, 812),
      builder: (context, _)
      => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App Title',
        // home: SignupScreenPage1(),
        home: LoginScreen(),
      ),
    );
  }
}
