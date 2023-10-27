import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/provider/signup_user_provider.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page3.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_either_button.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intermission_project/common/const/type_data.dart';
import 'package:provider/provider.dart';

class SignupScreenPage2 extends ConsumerStatefulWidget {
  static String get routeName => 'signup2';
  const SignupScreenPage2({super.key});

  @override
  ConsumerState<SignupScreenPage2> createState() => _SignupScreenPage2State();
}

class _SignupScreenPage2State extends ConsumerState<SignupScreenPage2> {
  final globalKey = GlobalKey<FormState>();
  TextEditingController raisePetController = TextEditingController();
  TextEditingController residenceAreaController = TextEditingController();
  TextEditingController possibleAreaController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  bool marriedSelected = false;
  bool unMarriedSelected = false;

  bool raisePet = false;
  bool raiseNoPet = false;
  bool isJobValid = false;

  String? residenceTypeErrorText;
  String? residenceAreaErrorText;
  String? kindOfPetErrorText;
  String? jobErrorText;

  bool isAreaValid = false;

  final userType = ['선택', '개인', '공공기관', '기업'];

  String? selectedUserType;

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

  /// 10(초등학생), 11(중학생), 12(고등학생), 13(대학생), 14(대학원생),
  /// 15(직장인), 16(유학생), 17(공무원), 18(군인), 99(기타)
  ///
  ///
  final jobCdType = jobCdTypes;
  String? selectedJobCdType;

  final petType = petTypes;

  String? selectedPetType;

  final asignCdType = asignCdTypes;

  List<Map<String, dynamic>> mapInfo = mapInfos;

  String? selectedAsignCdType;
  String? selectedCity;
  String? selectedCountry;
  String? intvSelectedCity;
  String? intvSelectedCountry;
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  bool isButtonEnabled = true;

  void checkButtonEnabled() {
    // bool isMarriedSelected = marriedSelected || unMarriedSelected; //결혼 여부
    // bool isRaisingPetSelected = (raisePet && selectedPetType != petType[0]) ||
    //     raiseNoPet; //반려동물을 키우는지, 키운다면 어떤 종류인지 기입했는가까지,
    // // bool isRaisingPetSelected = selectedPetType != petType[0];
    //
    // bool isResidenceTypeSelected =
    //     selectedResidenceType != residenceType[0]; //거주 형태
    // bool isJobSelected = selectedJobCdType != jobCdType[0];
    // bool isSelectedCity = selectedCity != null;
    // bool isSelectedCountry = selectedCountry != null;
    //
    // bool isFieldsValid = isMarriedSelected &&
    //     isRaisingPetSelected &&
    //     isResidenceTypeSelected &&
    //     isJobSelected;
    // setState(() {
    //   isButtonEnabled = isFieldsValid && isSelectedCity && isSelectedCountry;
    // });
  }

  void checkJobEnabled() {
    String job = jobController.text.trim();
    bool isValid = job.length >= 3;

    setState(() {
      isJobValid = isValid;
    });
    checkButtonEnabled();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(
      () {
        selectedUserType = userType[0];
        selectedResidenceType = residenceType[0];
        selectedAsignCdType = asignCdType[0];
        selectedJobCdType = jobCdType[0];
        selectedPetType = petType[0];
        jobController.addListener(checkJobEnabled);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);
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
              child: Form(
                key: globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SignupAppBar(currentPage: '2/3'),
                    SignupAskLabel(text: '개인/공공기관/기업'),
                    Center(
                      child: CustomDropdownButton(
                        items: userType,
                        hintText: '선택',
                        onItemSelected: (value) {
                          setState(
                            () {
                              selectedUserType = value;
                            },
                          );
                          checkButtonEnabled();
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SignupAskLabel(text: '직업/학생'),
                    Center(
                      child: CustomDropdownButton(
                        items: jobCdType,
                        hintText: '선택',
                        onItemSelected: (value) {
                          setState(
                            () {
                              selectedJobCdType = value;
                            },
                          );
                          checkButtonEnabled();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (selectedJobCdType == jobCdType[6])
                      SignupAskLabel(text: '담당 업무'),
                    if (selectedJobCdType == jobCdType[6])
                      Center(
                        child: CustomDropdownButton(
                          items: asignCdType,
                          hintText: '선택',
                          onItemSelected: (value) {
                            setState(
                              () {
                                selectedAsignCdType = value;
                              },
                            );
                            checkButtonEnabled();
                          },
                        ),
                      ),
                    if (selectedJobCdType == jobCdType[6])
                      SizedBox(
                        height: 20,
                      ),
                    if (selectedJobCdType == jobCdType[9])
                      SizedBox(
                        height: 20,
                      ),
                    if (selectedJobCdType == jobCdType[9])
                      SignupAskLabel(text: '직장(기타를 고른 경우)'),
                    if (selectedJobCdType == jobCdType[9])
                      CustomTextFormField(
                        controller: jobController,
                        hintText: '학생(학교명), 직장인(직무) 형식으로 입력해 주세요',
                        onChanged: (String value) {
                          checkJobEnabled();
                        },
                        errorText: isJobValid ? null : jobErrorText,
                        textFieldMinLine: 2,
                      ),
                    if (selectedJobCdType == jobCdType[9])
                      SizedBox(
                        height: 20,
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
                      height: 20,
                    ),
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
                    Center(
                      child: CustomDropdownButton(
                        items: petType,
                        hintText: '선택',
                        onItemSelected: (value) {
                          setState(
                            () {
                              selectedPetType = value;
                            },
                          );
                          checkButtonEnabled();
                        },
                      ),
                    ),
                    if (raisePet)
                      SizedBox(
                        height: 20,
                      ),
                    if (selectedPetType == petType[3])
                      SignupAskLabel(text: '키우시는 반려동물이 있으면 자유롭게 적어주세요'),
                    if (selectedPetType == petType[3])
                      CustomTextFormField(
                        controller: raisePetController,
                        hintText: '반려동물을 입력해 주세요',
                        onChanged: (String value) {
                          setState(() {});
                        },
                        enable: raisePet,
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    SignupAskLabel(text: '거주 지역'),
                    CustomDropdownButton(
                      items: mapInfo
                          .map((info) => info['name'].toString())
                          .toList(),
                      hintText: '시/도를 선택하세요.',
                      onItemSelected: (value) {
                        setState(() {
                          selectedCity = value;
                          selectedCountry = null;
                          checkButtonEnabled();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    CustomDropdownButton(
                      items: (selectedCity == null
                          ? []
                          : (mapInfo.firstWhere((info) =>
                                      info['name'] == selectedCity)['countries']
                                  as List)
                              .map((country) => country.toString())
                              .toList()),
                      hintText: '구/군을 선택하세요.',
                      onItemSelected: (value) {
                        setState(() {
                          selectedCountry = value;
                          checkButtonEnabled();
                        });
                      },
                      enabled: selectedCity != null, // 이 부분 추가
                      errorText: "시/도를 먼저 선택해주세요!", // 이 부분 추가
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    LoginNextButton(
                      buttonName: '다음',
                      isButtonEnabled: isButtonEnabled,
                      onPressed: () {
                        final state = ref.read(signupUserProvider.notifier);
                        state.setGenderCd(isMaleSelected == true ? "남성" : "여성");
                        state.setWedCd(marriedSelected == true ? "기혼" : "미혼");
                        state.setHouseCd(selectedResidenceType);
                        state.setPetCd(
                            selectedPetType == '선택' ? "없음" : selectedPetType);
                        state.setAsignJobCd(selectedAsignCdType == '선택'
                            ? "없음"
                            : selectedAsignCdType);
                        state.setJobCd(selectedJobCdType);
                        state.setOccpSidoCd(selectedCity);
                        state.setOccpSigunguCd(selectedCountry);
                        state.setUserCd(selectedUserType);
                        context.pushNamed(SignupScreenPage3.routeName);
                      },
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
