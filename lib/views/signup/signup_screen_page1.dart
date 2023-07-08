import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_either_button.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/views/signup/signup_screen_page2.dart';

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
    bool isValid = job.length >= 4;

    setState(() {
      isJobValid = isValid;
    });
    checkButtonEnabled();
  }

  void navigateToNextScreen(){ 
    if(isButtonEnabled) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignupScreenPage2()),);
    }
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
    bool isFieldsValid = isNameValid && isAgeValid && isPhoneNumValid && isJobValid;
    setState(() {
      isButtonEnabled = isGenderSelected && isFieldsValid;
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
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(12),
                right: ScreenUtil().setWidth(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignupAppBar(currentPage: '1/3'),
                SignupAskLabel(text: '이름'),
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
                SignupAskLabel(text: '성별'),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SignupEitherButton(
                    text: '남성',
                    isSelected: isMaleSelected,
                    onPressed: () {
                      setState(() {
                        isMaleSelected = true;
                        isFemaleSelected = false;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  SignupEitherButton(
                    text: '여성',
                    isSelected: isFemaleSelected,
                    onPressed: () {
                      setState(() {
                        isMaleSelected = false;
                        isFemaleSelected = true;
                      });
                    },
                  ),
                ]
                ),
                SizedBox(
                  height: 15,
                ),
              SignupAskLabel(text: '나이'),
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
                SignupAskLabel(text: '전화번호'),
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
              SignupAskLabel(text: '직업'),
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
    );
  }
}
