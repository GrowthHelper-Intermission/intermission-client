import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_either_button.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/views/signup/signup_screen_page2.dart';
import 'package:intermission_project/views/signup/signup_screen_page3.dart';

class SignupScreenPage2 extends StatefulWidget {
  const SignupScreenPage2({super.key});

  @override
  State<SignupScreenPage2> createState() => _SignupScreenPage2State();
}

class _SignupScreenPage2State extends State<SignupScreenPage2> {
  TextEditingController raisePetController = TextEditingController();
  TextEditingController residenceAreaController = TextEditingController();
  TextEditingController possibleAreaController = TextEditingController();

  bool marriedSelected = false;
  bool unMarriedSelected = false;

  bool raisePet = false;
  bool raiseNoPet = false;

  String? residenceTypeErrorText;
  String? residenceAreaErrorText;
  String? kindOfPetErrorText;

  bool isAreaValid = false;

  final residenceType = [
    '선택',
    '1인 가구',
    '2인 가구',
    '3인 가구',
    '4인 가구',
    '5인 가구',
    '6인 이상 가구',
  ];
  String? selectedResidenceType;

  bool isButtonEnabled = false;

  void checkButtonEnabled() {
    bool isMarriedSelected = marriedSelected || unMarriedSelected; //결혼 여부
    bool isRasingPetSelected =
        (raisePet && raisePetController.text.trim().isNotEmpty) ||
            raiseNoPet; //반려동물을 키우는지, 키운다면 어떤 종류인지 기입했는가까지,
    bool isResidenceTypeSelected =
        selectedResidenceType != residenceType[0]; //거주 형태
    bool isAreaSelected = isAreaValid; //거주 지역

    bool isFieldsValid = isMarriedSelected &&
        isRasingPetSelected &&
        isResidenceTypeSelected &&
        isAreaSelected;
    setState(() {
      isButtonEnabled = isFieldsValid;
    });
  }

  void checkAreaEnabled() {
    //조건 수정 필요
    String name = residenceAreaController.text.trim();
    bool isValid = name.length >= 2;

    setState(() {
      isAreaValid = isValid;
      residenceAreaErrorText = isAreaValid ? null : '비워둘 수 없는 칸입니다.';
    });
    checkButtonEnabled();
  }

  // void checkKindOfPet() {
  //   String pet = raisePetController.text.trim();
  //   setState(() {
  //     kindOfPetErrorText = (raisePet && pet.isEmpty) ? '반려동물을 입력해 주세요' : null;
  //   });
  //   checkButtonEnabled();
  // }

  void navigateToNextScreen() {
    if (isButtonEnabled) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignupScreenPage3()),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedResidenceType = residenceType[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: BORDER_COLOR,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    );

    // Function to close the dropdown when tapping outside
    void closeDropdown() {
      FocusScope.of(context).requestFocus(FocusNode());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: closeDropdown,
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
                  SignupAppBar(currentPage: '2/3'),
                  SignupAskLabel(text: '결혼 여부'),
                  Row(
                    children: [
                      SignupEitherButton(
                          text: '미혼',
                          isSelected: unMarriedSelected,
                          onPressed: () {
                            setState(() {
                              unMarriedSelected = true;
                              marriedSelected = false;
                              checkButtonEnabled();
                            });
                          }),
                      SizedBox(width: 10),
                      SignupEitherButton(
                          text: '기혼',
                          isSelected: marriedSelected,
                          onPressed: () {
                            setState(() {
                              marriedSelected = true;
                              unMarriedSelected = false;
                              checkButtonEnabled();
                            });
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SignupAskLabel(text: '거주 형태'),
                  Center(
                    child: CustomDropdownButton(
                      items: residenceType,
                      hintText: '선택',
                      onItemSelected: (value) {
                        setState(
                          () {
                            selectedResidenceType = value;
                          },
                        );
                        checkButtonEnabled();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SignupAskLabel(text: '반려동물을 키우시나요?'),
                  Row(
                    children: [
                      SignupEitherButton(
                          text: '네',
                          isSelected: raisePet,
                          onPressed: () {
                            setState(() {
                              raisePet = true;
                              raiseNoPet = false;
                              checkButtonEnabled();
                            });
                          }),
                      SizedBox(width: 10),
                      SignupEitherButton(
                          text: '아니오',
                          isSelected: raiseNoPet,
                          onPressed: () {
                            setState(() {
                              raiseNoPet = true;
                              raisePet = false;
                              checkButtonEnabled();
                            });
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (raisePet)
                    SignupAskLabel(text: '키우시는 반려동물이 있으면 자유롭게 적어주세요'),
                  if (raisePet)
                    CustomTextFormField(
                      controller: raisePetController,
                      hintText: '반려동물을 입력해 주세요',
                      onChanged: (String value) {
                        setState(() {});
                      },
                      errorText:
                          raisePet && raisePetController.text.trim().isEmpty
                              ? '반려동물을 입력해 주세요'
                              : null,
                      enable: raisePet,
                    ),
                  SignupAskLabel(text: '거주지역'),
                  CustomTextFormField(
                    controller: residenceAreaController,
                    hintText: '구까지 입력해 주세요',
                    onChanged: (String value) {
                      setState(() {});
                      checkAreaEnabled();
                    },
                    errorText: isAreaValid ? null : residenceAreaErrorText,
                  ),
                  SignupAskLabel(text: '인터뷰 가능 지역'),
                  SizedBox(
                    child: Text(
                      '비대면 인터뷰도 있지만 대면 인터뷰의 경우 인터뷰 하는 사람이 여러분 편의에 맞춰 일정을 조율할 것입니다. '
                      '거주지역과 동일할 시 넘어가주시기 바랍니다.',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  CustomTextFormField(
                    controller: possibleAreaController,
                    hintText: '지역을 입력해 주세요',
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  LoginNextButton(
                    buttonName: '다음',
                    isButtonEnabled: isButtonEnabled,
                    onPressed: navigateToNextScreen,
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
