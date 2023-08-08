import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/01.user/user/repository/user_me_repository.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_either_button.dart';
import 'package:intermission_project/common/component/signup_long_ask_label.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:flutter/foundation.dart'; // Import the 'foundation' package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreenPage3 extends ConsumerStatefulWidget {
  static String get routeName => 'signup3';
  const SignupScreenPage3({super.key});

  @override
  ConsumerState<SignupScreenPage3> createState() => _SignupScreenPage3State();
}

class _SignupScreenPage3State extends ConsumerState<SignupScreenPage3> {
  final globalKey = GlobalKey<FormState>();

  TextEditingController usingServiceController = TextEditingController();
  TextEditingController yourHobbyController = TextEditingController();
  TextEditingController recommandNameController = TextEditingController();

  final interviewRewards = [
    '선택',
    '5000원 ~ 10000원',
    '10000원 ~ 20000원',
    '20000원 ~ 30000원',
    '30000원 ~ 40000원',
    '40000원 ~ 50000원',
    '50000원 이상',
  ];
  String? selectedInterviewRewardType;
  bool isButtonEnabled = false;
  bool isSelectedInterviewReward = false;
  bool isAgree = false;

  void checkButtonEnabled() {
    bool isSelectedInterviewReward =
        selectedInterviewRewardType != interviewRewards[0]; //거주 형태
    bool isFieldsValid = isSelectedInterviewReward && isAgree;
    setState(() {
      isButtonEnabled = isFieldsValid;
    });
  }

  // void navigateToNextScreen() async {
  //   if (isButtonEnabled) {
  //     final loginUserProvider =
  //         Provider.of<LoginUserProvider>(context, listen: false);
  //
  //     loginUserProvider.setInterviewReward(selectedInterviewRewardType!);
  //     loginUserProvider
  //         .setOftenUsingService(usingServiceController.text.trim());
  //     loginUserProvider.setHobby(yourHobbyController.text.trim());
  //     loginUserProvider.setRecommendWho(recommandNameController.text.trim());
  //     loginUserProvider.setIsAgree(isAgree);
  //     loginUserProvider.setCreatedTime(DateTime.now().toString());
  //     loginUserProvider.setUserPoint(1000);
  //
  //     Map<String, dynamic> userData = {
  //       "emailAccount": loginUserProvider.emailAccount,
  //       "password": loginUserProvider.password,
  //       "name": loginUserProvider.name,
  //       "createdTime": loginUserProvider.createdTime,
  //       "gender": loginUserProvider.gender,
  //       "age": loginUserProvider.age,
  //       "job": loginUserProvider.job,
  //       "isMarried": loginUserProvider.isMarried,
  //       "residenceType": loginUserProvider.residenceType,
  //       "isRaisePet": loginUserProvider.isRaisePet,
  //       "kindOfPet": loginUserProvider.kindOfPet,
  //       "residenceArea": loginUserProvider.residenceArea,
  //       "interviewPossibleArea": loginUserProvider.interviewPossibleArea,
  //       "interviewReward": loginUserProvider.interviewReward,
  //       "oftenUsingService": loginUserProvider.oftenUsingService,
  //       "hobby": loginUserProvider.hobby,
  //       "recommendWho": loginUserProvider.recommendWho,
  //       "userPoint": loginUserProvider.userPoint,
  //       "isAgree": loginUserProvider.isAgree,
  //       "createdTime": loginUserProvider.createdTime,
  //       "emailVerified": loginUserProvider.emailVerified,
  //       "phoneNumber": loginUserProvider.phoneNumber,
  //       'scrapedInterviews': loginUserProvider.scrapedInterviews,
  //     };
  //
  //     String uid = loginUserProvider.emailAccount;
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(uid)
  //         .set(userData);
  //
  //     SharedPreferences sp = await SharedPreferences.getInstance();
  //     sp.setString(userId, loginUserProvider.emailAccount);
  //     sp.setString(userPassword, loginUserProvider.password);
  //     sp.setBool(autoLoginKey, true);
  //
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => RootTab(),
  //       ),
  //       (route) => false,
  //     );
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedInterviewRewardType = interviewRewards[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SignupLongAskLabel(
                      text: '1시간이 걸리는 비대면(온라인) 인터뷰 보상이 어느정도 되어야 인터뷰에 응하시겠습니까?'),
                  Center(
                    child: CustomDropdownButton(
                      items: interviewRewards,
                      hintText: '선택',
                      onItemSelected: (value) {
                        setState(
                              () {
                            selectedInterviewRewardType = value;
                          },
                        );
                        checkButtonEnabled();
                      },
                    ),
                  ),
                  SignupLongAskLabel(
                      text: '평소 자주 사용하는 웹/앱 서비스를 최대한 많이 적어주세요. 매칭이 쉬워집니다 !'),
                  CustomTextFormField(
                    controller: usingServiceController,
                    hintText: '의견을 입력해 주세요',
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                  SignupLongAskLabel(text: '취미를 적어주세요'),
                  CustomTextFormField(
                    controller: yourHobbyController,
                    hintText: '의견을 입력해 주세요',
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                  SignupLongAskLabel(text: '추천인 이름(나이)'),
                  Container(
                    constraints: BoxConstraints(maxWidth: 360),
                    child: Text(
                      '추후 웹 or 앱 개발 시 포인트 제도를 도입할 예정입니다. 추천인 한 명당 500포인트를 지급해드릴 것이니 많은 공유 부탁드립니다. 나이는 동명이인 문제로 부탁드리는 것입니다.',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  CustomTextFormField(
                    controller: recommandNameController,
                    hintText: '추천인을 입력해 주세요',
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                  PrivacyAgreement(
                    isAgree: isAgree,
                    onChanged: (value) {
                      // 여기을 onChanged에서 value를 받도록 수정했습니다.
                      setState(() {
                        isAgree = value!;
                        checkButtonEnabled();
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: LoginNextButton(
                      buttonName: '완료',
                      isButtonEnabled: isButtonEnabled,
                      onPressed: () async{
                        ref.read(userMeProvider.notifier).updateUser(
                            oflIntvRwdTpCd: selectedInterviewRewardType,
                            onlIntvRwdTpCd: selectedInterviewRewardType,
                            hobySubs: yourHobbyController.text.trim(),
                            rcmdUserCd: recommandNameController.text.trim(),
                            isAgreeYn: isAgree == true ? "동의함" : "동의하지 않음",
                            frstRegtDt: DateTime.now().toString(),
                            joinDay: DateTime.now().toString()
                          ///

                        );
                        //못돌아감
                        context.goNamed(RootTab.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrivacyAgreement extends StatelessWidget {
  final bool isAgree;
  final ValueChanged<bool?>
  onChanged; // 여기을 VoidCallback에서 ValueChanged<bool?>로 변경했습니다.

  const PrivacyAgreement({
    required this.isAgree,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                value: isAgree,
                activeColor: Colors.black,
                checkColor: Colors.white,
                onChanged: onChanged,
              ),
            ),
            const Text(
              '개인정보 수집 및 활용동의',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 110),
            InkWell(
              onTap: () {
                // '보기' 버튼을 눌렀을 때 슬라이드로 넘어가는 동작 구현
              },
              child: const Text(
                '보기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}