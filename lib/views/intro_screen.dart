// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:intermission_project/common/component/alert_dialog.dart';
// import 'package:intermission_project/common/component/circular_progress_indicator.dart';
// import 'package:intermission_project/common/component/custom_appbar.dart';
// import 'package:intermission_project/common/component/custom_text_form_field.dart';
// import 'package:intermission_project/common/component/login_next_button.dart';
// import 'package:intermission_project/common/component/main_tab_controller.dart';
// import 'package:intermission_project/common/const/colors.dart';
// import 'package:intermission_project/common/const/data.dart';
// import 'package:intermission_project/models/user.dart';
// import 'package:intermission_project/user/find_pw_button.dart';
// import 'package:intermission_project/common/component/custom_text_style.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intermission_project/views/login/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class IntroScreen extends StatefulWidget {
//   const IntroScreen({super.key});
//
//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }
//
// class _IntroScreenState extends State<IntroScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     initializeFlutterFire();
//     super.initState();
//   }
//
//   void initializeFlutterFire() async {
//     await Firebase.initializeApp();
//   }
//
//   // 실행시에 처음 보여줄 화면 - splash screen(로딩중)
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: PRIMARY_COLOR,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/img/logo.png'), //고등어 이미지.
//             ElevatedButton(
//               onPressed: tryLogin,
//               child: Text('시작하기'),
//             ),
//             /*ElevatedButton(
//               onPressed: test,
//
//               child: Text('Dio Test'),
//             )*/
//           ],
//         ),
//       ),
//     );
//   }
//
//   void tryLogin() async {
//     String stateId;
//     String statePassword;
//     bool login;
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     try {
//       stateId = sp.getString(userId)!;
//       statePassword = sp.getString(userPassword)!;
//       login = sp.getBool(loginState)!;
//
//       if (login == true) {
//         FirebaseFirestore firestore = FirebaseFirestore.instance;
//         String emailAccount;
//         String password;
//         String name;
//         String createdTime;
//         String gender;
//         int age;
//         String job;
//         bool isMarried;
//         String residenceType;
//         bool isRaisePet;
//         String kindOfPet;
//         String residenceArea;
//         String interviewPossibleArea;
//         String interviewReward;
//         String oftenUsingService;
//         String hobby;
//         String recommendWho;
//         String userPoint;
//         bool isAgree;
//         DocumentSnapshot userData;
//         try {
//           CustomCircularProgressIndicator(context, '로그인중...');
//           userData = await firestore.collection('users').doc(stateId).get();
//           emailAccount = userData['emailAccount'];
//           password = userData['password'];
//           if (emailAccount == stateId && password == password) {
//             name = userData['name'];
//             createdTime = userData['createdTime'];
//             gender = userData['gender'];
//             age = userData['age'];
//             job = userData['job'];
//             isMarried = userData['isMarried'];
//             residenceType = userData['residenceType'];
//             isRaisePet = userData['isRaisePet'];
//             kindOfPet = userData['kindOfPet'];
//             residenceArea = userData['residenceArea'];
//             interviewPossibleArea = userData['interviewPossibleArea'];
//             interviewReward = userData['interviewReward'];
//             oftenUsingService = userData['oftenUsingService'];
//             hobby = userData['hobby'];
//             recommendWho = userData['recommendWho'];
//             userPoint = userData['userPoint'];
//             isAgree = userData['isAgree'];
//
//             LoginUserProvider user = LoginUserProvider();
//             user.setEmailAccount(emailAccount);
//             user.setPassword(password);
//             user.setName(name);
//             user.setCreatedTime(createdTime);
//             user.setGender(gender);
//             user.setAge(age);
//             user.setJob(job);
//             user.setIsMarried(isMarried);
//             user.setResidenceType(residenceType);
//             user.setIsRaisePet(isRaisePet);
//             user.setKindOfPet(kindOfPet);
//             user.setResidenceArea(residenceArea);
//             user.setInterviewPossibleArea(interviewPossibleArea);
//             user.setInterviewReward(interviewReward);
//             user.setOftenUsingService(oftenUsingService);
//             user.setHobby(hobby);
//             user.setRecommendWho(recommendWho);
//             user.setUserPoint(userPoint);
//             user.setIsAgree(isAgree);
//
//             Navigator.pop(context);
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (BuildContext context) {
//               return MainTabController(user: user);
//             }));
//           } else {
//             Navigator.pop(context);
//             DialogShow(context, '회원정보가 잘못되었습니다.');
//           }
//         } catch (e) {
//           Navigator.pop(context);
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
//           );
//         }
//       } else {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (BuildContext context) {
//               return LoginScreen(); //로그인 화면으로 이동.
//             },
//           ),
//         );
//       }
//     } catch (e) {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (BuildContext context) {
//             return LoginScreen(); //로그인 화면으로 이동.
//           },
//         ),
//       );
//     }
//   }
// }
//
// class intro_bottom extends StatefulWidget {
//   const intro_bottom({Key? key}) : super(key: key);
//
//   @override
//   State<intro_bottom> createState() => _intro_bottomState();
// }
//
// class _intro_bottomState extends State<intro_bottom> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 32.0),
//       child: Column(
//         children: [
//           Text(
//             'ⓒConnect-High',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 10.0,
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Text(
//             '고등학생들의 커뮤니티',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 11.0,
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Text(
//             'Test.ver',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 10.0,
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/alert_dialog.dart';
import 'package:intermission_project/common/component/circular_progress_indicator.dart';
import 'package:intermission_project/common/component/main_tab_controller.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/models/user.dart';
import 'package:intermission_project/views/login/login_screen.dart';
import 'package:intermission_project/views/signup/signup_screen_page1.dart';
import 'package:intermission_project/views/signup/signup_screen_page2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/logo.png'), //고등어 이미지.
            ElevatedButton(
              onPressed: tryLogin,
              child: Text('시작하기'),
            ),
            const IntroBottom(),
          ],
        ),
      ),
    );
  }


  //tryLogin 부분 수정 필요(hot reload 2번이상하면 autoLogin이 초기화)
  void tryLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {

      String stateId = sp.getString(userId) ?? '';
      String statePassword = sp.getString(userPassword) ?? '';
      // String stateId = "test@naver.com";
      // String statePassword = "71245a";

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot userData = await firestore.collection('users').doc(stateId).get();
      LoginUserProvider user = LoginUserProvider.fromSnapshot(userData);

      bool autoLogin = user.autoLogin ?? false; // 추가 상태 키

      print(stateId);
      print(autoLogin);
      if (autoLogin && stateId.isNotEmpty) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        try {
          CustomCircularProgressIndicator(context, '로그인중...');
          // DocumentSnapshot userData = await firestore.collection('users').doc(stateId).get();
          // LoginUserProvider user = LoginUserProvider.fromSnapshot(userData);

          if (stateId == user.emailAccount && statePassword == user.password) {
            SharedPreferences sp = await SharedPreferences.getInstance();
            // 1.Update autoLogin value
            user.setAutoLogin(autoLogin);
            // 2. Save user data in Firestore
            String uid = user.emailAccount;
            await FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .update({"autoLogin": true});

            // 3. Save autoLogin value in SharedPreferences
            sp.setBool(autoLoginKey, autoLogin);
            print(autoLogin);
            Navigator.pop(context);
            goToMainScreen(user);
          } else {
            showErrorDialog(context, '회원정보가 잘못되었습니다.');
          }
        } catch (e) {
          goToSignUpPage2Screen();
        }
      } else {
        goToLoginScreen(context);
        print(autoLogin);
      }
    } catch (e) {
      goToLoginScreen(context);
    }
  }


  void goToMainScreen(LoginUserProvider user) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MainTabController(user: user)));
  }

  void goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void goToSignUpPage1Screen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignupScreenPage1()));
  }

  void goToSignUpPage2Screen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignupScreenPage2()));
  }

  void showErrorDialog(BuildContext context, String message) {
    DialogShow(context, message);
  }
}

class IntroBottom extends StatelessWidget {
  const IntroBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        children: [
          Text(
            'Growth Helper',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Text(
            '꿀수익 보장!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Text(
            'Test.ver',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

