// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intermission_project/common/component/custom_appbar.dart';
// import 'package:intermission_project/common/component/custom_text_form_field.dart';
// import 'package:intermission_project/common/component/custom_text_style.dart';
// import 'package:intermission_project/common/const/colors.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/const/colors.dart';

extension InputValidate on String {
  // 이메일 포맷 검증
  bool isValidEmailFormat() {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }

  // 대쉬를 포함하는 010 휴대폰 번호 포맷 검증 (010-1234-5678)
  bool isValidPhoneNumberFormat() {
    return RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(this);
  }
}

class SignupScreenPage1 extends StatefulWidget {
  const SignupScreenPage1({Key? key}) : super(key: key);

  @override
  State<SignupScreenPage1> createState() => _SignupScreenPage1State();
}

class _SignupScreenPage1State extends State<SignupScreenPage1> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  bool isNameValid = false;
  bool isAgeValid = false;
  bool isPhoneNumValid = false;
  bool isJobValid = false;

  String? nameErrorText;
  String? ageErrorText;
  String? phoneNumErrorText;
  String? jobErrorText;

  bool isButtonEnabled = false;
  bool isGenderSelected = false;
  bool isFieldsValid = false;

  void checkNameEnabled() {
    String name = nameController.text.trim();
    bool isValid = RegExp(r'^[a-zA-Z가-힣]{2,}$').hasMatch(name);

    setState(() {
      isNameValid = isValid;
      nameErrorText = isValid ? null : '영문자 또는 한글로 2자 이상 입력해 주세요';
    });
    checkButtonEnabled();
  }

  void checkAgeEnabled() {
    String age = ageController.text.trim();
    bool isValid = RegExp(r'^[0-9]+$').hasMatch(age);

    setState(() {
      isAgeValid = isValid;
      ageErrorText = isValid ? null : '숫자만 입력해 주세요';
    });
    checkButtonEnabled();
  }

  void checkPhoneNumEnabled() {
    String number = phoneNumController.text.trim();
    bool isValid = number.isValidPhoneNumberFormat();

    setState(() {
      isPhoneNumValid = isValid;
      phoneNumErrorText = isValid ? null : '올바른 전화번호 형식이 아닙니다';
    });
    checkButtonEnabled();
  }

  void checkJobEnabled() {
    String job = jobController.text.trim();
    bool isValid = job.length >= 1;

    setState(() {
      isJobValid = isValid;
    });
    checkButtonEnabled();
  }

  @override
  void initState() {
    // TODO: implement initState
    nameController.addListener(checkNameEnabled);
    ageController.addListener(checkAgeEnabled);
    phoneNumController.addListener(checkPhoneNumEnabled);
    jobController.addListener(checkJobEnabled);
    super.initState();
  }

  void checkButtonEnabled() {
    bool isGenderSelected = isMaleSelected || isFemaleSelected;
    bool isFieldsValid = isNameValid && isAgeValid && isPhoneNumValid;
    setState(() {
      isButtonEnabled = isGenderSelected;
    });
  }




  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneNumController.dispose();
    super.dispose();
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
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: SizedBox(
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setHeight(50),
                        child: Text(
                          '회원가입',
                          style: customHeaderStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setHeight(50),
                      child: Text(
                        '1/3',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 60,
                  height: 22,
                  child: Text(
                    '이름',
                    style: customTextStyle,
                  ),
                ),
                CustomTextFormField(
                  controller: nameController,
                  hintText: '이름을 입력해 주세요',
                  onChanged: (String value) {
                    checkNameEnabled();
                  },
                  errorText: isNameValid ? null : nameErrorText,
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 60,
                  height: 22,
                  child: Text(
                    '성별',
                    style: customTextStyle,
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMaleSelected = true;
                        isFemaleSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isMaleSelected ? SUB_COLOR : Colors.white,
                      minimumSize: Size(170, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(
                          color: isMaleSelected
                              ? Colors.transparent
                              : BORDER_COLOR,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      '남성',
                      style: TextStyle(
                        color: isMaleSelected ? Colors.black : Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMaleSelected = false;
                        isFemaleSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isFemaleSelected ? SUB_COLOR : Colors.white,
                      minimumSize: Size(170, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(
                          color: isFemaleSelected
                              ? Colors.transparent
                              : BORDER_COLOR,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      '여성',
                      style: TextStyle(
                        color: isFemaleSelected ? Colors.black : Colors.grey[600],
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 60,
                  height: 22,
                  child: Text(
                    '나이',
                    style: customTextStyle,
                  ),
                ),
                CustomTextFormField(
                  controller: ageController,
                  hintText: '나이를 입력해 주세요',
                  onChanged: (String value) {
                    checkAgeEnabled();
                  },
                  errorText: isAgeValid ? null : ageErrorText,
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 60,
                  height: 22,
                  child: Text(
                    '전화번호',
                    style: customTextStyle,
                  ),
                ),
                CustomTextFormField(
                  controller: phoneNumController,
                  hintText: '000-000-0000 형식으로 입력해 주세요',
                  onChanged: (String value) {
                    checkPhoneNumEnabled();
                  },
                  errorText: isPhoneNumValid ? null : phoneNumErrorText,
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 60,
                  height: 22,
                  child: Text(
                    '직업',
                    style: customTextStyle,
                  ),
                ),
                CustomTextFormField(
                  controller: jobController,
                  hintText: '학생(학교명), 직장인(직무) 형식으로 입력해 주세요',
                  onChanged: (String value) {
                    checkJobEnabled();
                  },
                  errorText: isJobValid ? null : jobErrorText,
                  textFieldMinLine: 2,
                ),
                SizedBox(
                  height: 50,
                ),
                LoginNextButton(buttonName: '다음', isButtonEnabled: isButtonEnabled),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

