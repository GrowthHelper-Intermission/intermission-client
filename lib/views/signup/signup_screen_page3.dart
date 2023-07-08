import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_either_button.dart';
import 'package:intermission_project/common/component/signup_long_ask_label.dart';
import 'package:intermission_project/common/component/tabbar_using_controller.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/views/signup/signup_screen_page2.dart';
import 'package:flutter/foundation.dart'; // Import the 'foundation' package

class SignupScreenPage3 extends StatefulWidget {
  const SignupScreenPage3({super.key});

  @override
  State<SignupScreenPage3> createState() => _SignupScreenPage3State();
}

class _SignupScreenPage3State extends State<SignupScreenPage3> {
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

  void navigateToNextScreen() {
    if (isButtonEnabled) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabBarController()),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedInterviewRewardType = interviewRewards[0];
    });
  }

  // 드롭박스.
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  static const double _dropdownWidth = 360;
  static const double _dropdownHeight = 48;

  // CustomDropdown method
  OverlayEntry _customDropdown() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: _dropdownWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, _dropdownHeight),
          child: Material(
            color: Colors.white,
            child: Container(
              height: (22.0 * interviewRewards.length) +
                  (21 * (interviewRewards.length - 1)) +
                  20,
              decoration: BoxDecoration(
                border: Border.all(color: BORDER_COLOR),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: interviewRewards.length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    pressedOpacity: 1,
                    minSize: 0,
                    onPressed: () {
                      setState(() {
                        selectedInterviewRewardType =
                            interviewRewards.elementAt(index);
                        checkButtonEnabled();
                      });
                      _removeOverlay();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        interviewRewards.elementAt(index),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 22 / 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isOpen = false; // 드롭다운이 열려있는지 여부

  // 드롭다운 생성.
  void _createOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _customDropdown();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  // 드롭다운 해제.
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _overlayEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: GestureDetector(
        onTap: () {
          _removeOverlay(); //드롭다운 버튼 클릭한상태로 바깥화면클릭시 버튼 닫히게
        },
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(12),
                  right: ScreenUtil().setWidth(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SignupAppBar(currentPage: '3/3'),
                  SignupLongAskLabel(
                      text: '1시간이 걸리는 비대면(온라인) 인터뷰 보상이 어느정도 되어야 인터뷰에 응하시겠습니까?'),
                  Center(
                    child: InkWell(
                      onTap: () {
                        _createOverlay();
                        checkButtonEnabled();
                      },
                      child: CompositedTransformTarget(
                        link: _layerLink,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 2, right: 14), //수정
                          child: Container(
                            width: _dropdownWidth,
                            height: _dropdownHeight,
                            padding: EdgeInsets.only(left: 6), //수정
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BORDER_COLOR,
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 선택값.
                                Text(
                                  selectedInterviewRewardType.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 22 / 16,
                                    color: Colors.black,
                                  ),
                                ),
                                // 아이콘.
                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 36,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                      onPressed: navigateToNextScreen,
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

// Padding(
//   padding: const EdgeInsets.only(right: 15),
//   child: Container(
//     height: 60,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SizedBox(
//           width: 30,
//           height: 30,
//           child: Checkbox(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             value: isAgree, // 체크 상태에 따라 변경
//             activeColor: Colors.black, // 선택된 상태의 색상
//             checkColor: Colors.white, // 체크 표시의 색상
//             onChanged: (press) {
//               setState(() {
//                 isAgree = press!;
//                 checkButtonEnabled();
//               });
//             },
//           ),
//         ),
//         const Text(
//           '개인정보 수집 및 활용동의',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(width: 110,),
//         InkWell(
//           onTap: () {
//             // '보기' 버튼을 눌렀을 때 슬라이드로 넘어가는 동작 구현
//           },
//           child: const Text(
//             '보기',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
