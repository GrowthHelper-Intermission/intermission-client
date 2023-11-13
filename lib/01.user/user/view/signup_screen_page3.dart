// import 'dart:ui';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
// import 'package:intermission_project/01.user/user/provider/signup_user_provider.dart';
// import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
// import 'package:intermission_project/01.user/user/view/login_screen.dart';
// import 'package:intermission_project/common/component/custom_appbar.dart';
// import 'package:intermission_project/common/component/custom_dropdown_button.dart';
// import 'package:intermission_project/common/component/custom_text_form_field.dart';
// import 'package:intermission_project/common/component/login_next_button.dart';
// import 'package:intermission_project/common/component/signup_appbar.dart';
// import 'package:intermission_project/common/component/signup_long_ask_label.dart';
// import 'package:intermission_project/common/dio/dio.dart';
// import 'package:flutter/foundation.dart'; // Import the 'foundation' package
//
// class SignupScreenPage3 extends ConsumerStatefulWidget {
//   static String get routeName => 'signup3';
//   const SignupScreenPage3({super.key});
//
//   @override
//   ConsumerState<SignupScreenPage3> createState() => _SignupScreenPage3State();
// }
//
// class _SignupScreenPage3State extends ConsumerState<SignupScreenPage3> {
//   final globalKey = GlobalKey<FormState>();
//
//   TextEditingController usingServiceController = TextEditingController();
//   TextEditingController yourHobbyController = TextEditingController();
//   TextEditingController recommandNameController = TextEditingController();
//
//   final offlineInterviewRewards = [
//     '선택',
//     '5000원 ~ 10000원',
//     '10000원 ~ 20000원',
//     '20000원 ~ 30000원',
//     '30000원 ~ 40000원',
//     '40000원 ~ 50000원',
//     '50000원 이상',
//   ];
//
//   final onlineInterviewRewards = [
//     '선택',
//     '5000원 ~ 10000원',
//     '10000원 ~ 20000원',
//     '20000원 ~ 30000원',
//     '30000원 ~ 40000원',
//     '40000원 ~ 50000원',
//     '50000원 이상',
//   ];
//
//   String? selectedOfflineInterviewRewardType;
//   String? selectedOnlineInterviewRewardType;
//   bool isButtonEnabled = false;
//   bool isSelectedInterviewReward = false;
//   bool isAgree = false;
//
//   void checkButtonEnabled() {
//     bool isSelectedInterviewReward =
//         selectedOfflineInterviewRewardType != offlineInterviewRewards[0] &&
//             selectedOnlineInterviewRewardType != onlineInterviewRewards[0];
//     bool isFieldsValid = isSelectedInterviewReward && isAgree;
//     setState(() {
//       isButtonEnabled = isFieldsValid;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       selectedOfflineInterviewRewardType = offlineInterviewRewards[0];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           child: Padding(
//             padding: EdgeInsets.only(
//                 left: ScreenUtil().setWidth(12),
//                 right: ScreenUtil().setWidth(12)),
//             child: Form(
//               key: globalKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SignupAppBar(currentPage: '3/3'),
//                   SignupLongAskLabel(
//                       text: '비대면 인터뷰 보상이 어느정도 되어야 인터뷰에 응하시겠습니까?'),
//                   Center(
//                     child: CustomDropdownButton(
//                       items: offlineInterviewRewards,
//                       hintText: '선택',
//                       onItemSelected: (value) {
//                         setState(
//                           () {
//                             selectedOfflineInterviewRewardType = value;
//                           },
//                         );
//                         checkButtonEnabled();
//                       },
//                     ),
//                   ),
//                   SignupLongAskLabel(
//                       text: '대면 인터뷰 보상이 어느 정도 되어야 인터뷰에 응하시겠습니까?'),
//                   Center(
//                     child: CustomDropdownButton(
//                       items: onlineInterviewRewards,
//                       hintText: '선택',
//                       onItemSelected: (value) {
//                         setState(
//                           () {
//                             selectedOnlineInterviewRewardType = value;
//                           },
//                         );
//                         checkButtonEnabled();
//                       },
//                     ),
//                   ),
//                   SignupLongAskLabel(
//                       text: '평소 자주 사용하는 웹/앱 서비스를 최대한 많이 적어주세요. 매칭이 쉬워집니다 !'),
//                   CustomTextFormField(
//                     controller: usingServiceController,
//                     hintText: '의견을 입력해 주세요',
//                     onChanged: (String value) {
//                       setState(() {});
//                     },
//                   ),
//                   SignupLongAskLabel(text: '취미를 적어주세요'),
//                   CustomTextFormField(
//                     controller: yourHobbyController,
//                     hintText: '의견을 입력해 주세요',
//                     onChanged: (String value) {
//                       setState(() {});
//                     },
//                   ),
//                   SignupLongAskLabel(text: '추천인 이름(나이)'),
//                   Container(
//                     constraints: BoxConstraints(maxWidth: 360),
//                     child: Text(
//                       '추후 웹 or 앱 개발 시 포인트 제도를 도입할 예정입니다. 추천인 한 명당 500포인트를 지급해드릴 것이니 많은 공유 부탁드립니다. 나이는 동명이인 문제로 부탁드리는 것입니다.',
//                       style: TextStyle(
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14),
//                     ),
//                   ),
//                   CustomTextFormField(
//                     controller: recommandNameController,
//                     hintText: '추천인을 입력해 주세요',
//                     onChanged: (String value) {
//                       setState(() {});
//                     },
//                   ),
//                   PrivacyAgreement(
//                     isAgree: isAgree,
//                     onChanged: (value) {
//                       setState(() {
//                         isAgree = value!;
//                         checkButtonEnabled();
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: LoginNextButton(
//                       buttonName: '완료',
//                       isButtonEnabled: isButtonEnabled,
//                       onPressed: () async {
//
//                        final state = ref.read(signupUserProvider.notifier);
//                        state.setOflResRwdTpCd(selectedOfflineInterviewRewardType);
//                        state.setOnlResRwdTpCd(selectedOnlineInterviewRewardType);
//                        state.setHobySubs(yourHobbyController.text.trim());
//                        state.setRcmdUserCd(recommandNameController.text.trim());
//                        state.setIsAgreeYn( isAgree == true ? "Y" : "N");
//                        state.setDelYn("N");
//
//                        final SignupUserModel newUser = SignupUserModel(
//                          userCd: "개인",
//                          researchSidoCd: state.researchSidoCd ?? state.occpSidoCd,
//                          researchSigunguCd: state.researchSigunguCd ?? state.occpSigunguCd,
//                          jobGrdNm: "blank",
//                          jobCd: state.jobCd,
//                          asignJobCd: state.asignJobCd,
//                          accountNumber: state.accountNumber,
//                          bankAccount: state.bankAccount,
//                          isAgreeYn: state.isAgreeYn,
//                          hobySubs: state.hobySubs,
//                          onlResRwdTpCd: state.onlResRwdTpCd,
//                          oflResRwdTpCd: state.oflResRwdTpCd,
//                          petTpCd: state.petTpCd,
//                          houseCd: state.housTpCd,
//                          wedCd: state.wedTpCd,
//                          birthDay: state.birthDay,
//                          delYn: "N",
//                          email: state.email,
//                          genderCd: state.genderCd,
//                          hpNum: state.hpNum,
//                          mainUseOnlSvcCn: state.mainUseOnlSvcCn ?? "blank",
//                          occpSidoCd: state.occpSidoCd,
//                          occpSigunguCd: state.occpSigunguCd,
//                          petNm: "blank",
//                          petYn: state.petYn,
//                          password: state.pwd ?? "blank",
//                          userNm: state.userNm,
//                        );
//                        try{
//                          ref.read(userMeProvider.notifier).postUser(newUser);
//                          print('성공적 수행');
//                        }catch(e){
//                          print(e);
//                          print('에러');
//                        }
//                         context.goNamed(LoginScreen.routeName);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
import 'package:intermission_project/01.user/user/provider/signup_user_provider.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/01.user/user/view/certification_test.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_long_ask_label.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:flutter/foundation.dart'; // Import the 'foundation' package

class SignupScreenPage3 extends ConsumerStatefulWidget {
  static String get routeName => 'signup3';
  const SignupScreenPage3({super.key});

  @override
  ConsumerState<SignupScreenPage3> createState() => _SignupScreenPage3State();
}

class _SignupScreenPage3State extends ConsumerState<SignupScreenPage3> {
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(12),
                  right: ScreenUtil().setWidth(12)),
              child: Form(
                key: globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SignupAppBar(currentPage: '3/3'),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: LoginNextButton(
                        buttonName: '본인인증 실행하기',
                        isButtonEnabled: true,
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CertificationTest(),
                            ),
                          );
                          // try {
                          //   // ref.read(userMeProvider.notifier).postUser(newUser);
                          //   print('성공적 수행');
                          // } catch (e) {
                          //   print(e);
                          //   print('에러');
                          // }
                          // context.goNamed(LoginScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
