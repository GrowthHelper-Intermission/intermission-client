import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/signup_user_provider.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page2.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_date_picker.dart';
import 'package:intermission_project/common/component/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_either_button.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intl/intl.dart';

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

class SignupScreenPage1 extends ConsumerStatefulWidget {
  static String get routeName => 'signup1';
  const SignupScreenPage1({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreenPage1> createState() => _SignupScreenPage1State();
}

class _SignupScreenPage1State extends ConsumerState<SignupScreenPage1> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  // TextEditingController jobController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  bool isEmailValid = false;
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool isNameValid = false;
  bool isAgeValid = false;
  bool isPhoneNumValid = false;
  // bool isJobValid = false;
  bool isEmailVerified = false;
  bool isAccountNumberVerified = false;
  bool isButtonEnabled = false;
  bool isGenderSelected = false;
  bool isFieldsValid = false;
  bool accountNumberValid = false;
  bool duplicate = false; //중복 검사용

  String? nameErrorText;
  String? ageErrorText;
  String? phoneNumErrorText;
  // String? jobErrorText;
  String? emailErrorText;
  String? emailValidText;
  String? accountErrorText;

  // 전역 변수로 코드를 저장합니다.
  String? serverCode;

  // final bankAccountType = [
  //   '선택', '하나은행', 'SC제일은행', '경남은행', '광주은행', '국민은행', '기업은행', '농협은행', '대구은행', '부산은행', '산업은행', '새마을금고', '수협은행', '신한은행', '신협중앙회', '시티은행', '우리은행', '우체국', '전북은행', '제주은행', '카카오뱅크', '케이뱅크', '토스뱅크',
  // ];

  final bankAccountType = [
    '선택', '우리은행', '우체국', '전북은행', '제주은행', '카카오뱅크', '케이뱅크', '토스뱅크',
  ];

  String? selectedBankType;

  void sendEmailVerification() async {
    try {
      String email = emailController.text.trim();

      var dio = Dio();
      var data = {
        "emailAccount": email,
      };

      var response = await dio.post(
        'http://localhost:8080/api/email',
        data: data,
      );

      if (response.statusCode == 200) {
        serverCode = response.data["code"]; // 서버에서 반환된 코드를 저장합니다.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('이메일 인증 링크가 전송되었습니다. 이메일을 확인해 주세요.'),
        ));
      } else {
        print('Failed to send verification email');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> verifyCode() async {
    String userCode = codeController.text.trim(); // 사용자가 입력한 코드

    // 서버에서 반환된 코드와 사용자가 입력한 코드를 비교합니다.
    if (userCode == serverCode) {
      isEmailVerified = true;
      checkButtonEnabled();
      return true;
    } else {
      return false;
    }
  }

  // 이메일 중복 검사 함수
  void checkEmailEnabled() async {
    //중복 이메일 검사하기
    String email = emailController.text.trim();
    if (!email.isValidEmailFormat()) {
      setState(() {
        emailErrorText = "올바른 이메일 형식으로 입력해주세요!";
      });
      return;
    }

    //쿼리로 ID중복 여부 확인
    setState(() {
      if (duplicate) {
        emailErrorText = '이미 사용 중인 이메일입니다.';
        emailValidText = null;
      } else {
        isEmailValid = true;
        emailErrorText = null;
        emailValidText = '사용 가능한 이메일입니다.';
      }
    });
  }

  void checkPasswordEnabled() {}

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

  // void checkJobEnabled() {
  //   String job = jobController.text.trim();
  //   bool isValid = job.length >= 3;
  //
  //   setState(() {
  //     isJobValid = isValid;
  //   });
  //   checkButtonEnabled();
  // }

  void checkPhoneNumEnabled() {
    String number = phoneNumController.text.trim();
    bool isValid = number.isValidPhoneNumberFormat();

    setState(() {
      isPhoneNumValid = isValid;
      phoneNumErrorText = isValid ? null : '올바른 전화번호 형식이 아닙니다';
    });
    checkButtonEnabled();
  }

  void checkAccountEnabled() {
    String accountNumber = accountNumberController.text.trim();
    bool isAccountValid = accountNumber.length >= 9;
    setState(() {
      //phoneNumErrorText = isValid ? null : '올바른 전화번호 형식이 아닙니다';
      accountNumberValid = isAccountValid;
      accountErrorText = accountNumberValid ? null : '숫자만 입력해 주세요';
    });
    checkButtonEnabled();
  }

  @override
  void initState() {
    // TODO: implement initState
    nameController.addListener(checkNameEnabled);
    ageController.addListener(checkAgeEnabled);
    phoneNumController.addListener(checkPhoneNumEnabled);
    // jobController.addListener(checkJobEnabled);
    accountNumberController.addListener(checkAccountEnabled);
    selectedBankType = bankAccountType[0];
    super.initState();
  }

  void checkButtonEnabled() {
    bool isGenderSelected = isMaleSelected || isFemaleSelected;
    bool isFieldsValid = isEmailValid &&
        isNameValid &&
        isAgeValid &&
        isPhoneNumValid;
    bool bankAccountSelected = selectedBankType != bankAccountType[0];
    setState(() {
      isButtonEnabled = isGenderSelected &&
          isFieldsValid &
              isEmailVerified &
              bankAccountSelected &
              accountNumberValid;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneNumController.dispose();
    super.dispose();
  }

  TextEditingController birthdayController =
      TextEditingController(text: '생년월일을 선택해 주세요');

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(userMeProvider);

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SignupAppBar(currentPage: '1/3'),
                  SignupAskLabel(text: '이메일'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5, // 비율을 사용하여 width를 조절
                        child: CustomTextFormField(
                          controller: emailController,
                          hintText: 'email@email.com',
                          onChanged: (String value) {
                            checkEmailEnabled();
                          },
                          errorText: emailErrorText,
                        ),
                      ),
                      SizedBox(width: 10), // 텍스트 필드와 버튼 사이의 간격
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: sendEmailVerification,
                          child: Text('코드 발송'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SUB_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), // 모서리 깎기
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                  if (emailValidText != null)
                    Text(
                      emailValidText!,
                      style: TextStyle(color: PRIMARY_COLOR),
                    ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5, // 비율을 사용하여 width를 조절
                        child: CustomTextFormField(
                          controller: codeController,
                          hintText: '인증코드 입력',
                          onChanged: (String value) {},
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool isVerified = await verifyCode();
                            if (isVerified) {
                              isEmailVerified = true;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('인증이 완료되었습니다!')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('인증 코드가 일치하지 않습니다.')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SUB_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), // 모서리 깎기
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          child: Text('인증하기'),
                        ),
                      ),
                    ],
                  ),
                  SignupAskLabel(text: '비밀번호'),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: '6자 이상의 영문/숫자 조합',
                    onChanged: (String value) {},
                    obscureText: true,
                  ),
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
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  CustomDatePicker(
                    initialText: '생년월일을 입력해주세요',
                    labelText: '생년월일',
                    controller: birthdayController,
                    onDateSelected: (selectedDate) {
                      setState(() {
                        if (selectedDate != null) {
                          // 선택된 날짜를 사용하여 필요한 작업 수행
                          isAgeValid = true; // 예시
                          checkButtonEnabled();
                        }
                      });
                    },
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
                  SignupAskLabel(text: '사용 은행'),
                  Center(
                    child: CustomDropdownButton(
                      items: bankAccountType,
                      hintText: '선택',
                      onItemSelected: (value) {
                        setState(
                          () {
                            selectedBankType = value;
                          },
                        );
                        checkButtonEnabled();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SignupAskLabel(text: '계좌번호'),
                  CustomTextFormField(
                    controller: accountNumberController,
                    onChanged: (String value) {
                      checkAccountEnabled();
                    },
                    errorText: accountNumberValid ? null : accountErrorText,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  LoginNextButton(
                    buttonName: '다음',
                    isButtonEnabled: isButtonEnabled,
                    onPressed: () {
                      final state = ref.read(signupUserProvider.notifier);
                      //10개
                      state.setUserNm(nameController.text.trim());
                      state.setEmail(emailController.text.trim());
                      state.setUserId(emailController.text.trim());
                      state.setPwd(passwordController.text.trim());
                      state.setGenderCd(isMaleSelected == true ? "M" : "F");
                      state.setBirthDay(birthdayController.text.trim());
                      state.setHpNum(phoneNumController.text.trim());
                      state.setEmailVerfYn(isEmailVerified == true ? "Y" : "N");
                      state.setBankAccount(selectedBankType);
                      state.setAccountNumber(accountNumberController.text.trim());

                      // final state = ref.watch(userMeProvider.notifier) as UserModel;

                      print(state.wedTpCd);
                      context.pushNamed(SignupScreenPage2.routeName);
                    },
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

class CustomButton extends StatelessWidget {
  final bool
      istext; //버튼안에 들어갈 내용이 '중복확인' 텍스트인가 화살표아이콘인가를 결정해주는 변수임 164번줄에 이어서 주석달겠음.
  final String text;
  final VoidCallback onPressed;
  const CustomButton(
      {required this.text,
      required this.istext,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: PRIMARY_COLOR,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      onPressed: onPressed,
      child: istext == false
          ? Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 35.0,
            )
          : Text(text),
    );
  }
}