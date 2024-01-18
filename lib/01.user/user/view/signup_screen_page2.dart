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
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_either_button.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/type_data.dart';

import 'certification_test.dart';

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
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  bool raisePet = false;
  bool raiseNoPet = false;
  bool isJobValid = false;

  String? selectedUserType;
  String? selectedAsignCdType;
  String? selectedCity;
  String? selectedCountry;
  String? intvSelectedCity;
  String? intvSelectedCountry;

  String? selectedJobCdType;
  String? selectedPetType;

  bool isAreaValid = false;

  final jobCdType = jobCdTypes;

  final petType = petTypes;

  final asignCdType = asignCdTypes;

  final userType = ['선택', '개인', '공공기관', '기업'];

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

  String? residenceTypeErrorText;
  String? residenceAreaErrorText;
  String? kindOfPetErrorText;
  String? jobErrorText;

  /// 10(초등학생), 11(중학생), 12(고등학생), 13(대학생), 14(대학원생),
  /// 15(직장인), 16(유학생), 17(공무원), 18(군인), 99(기타)
  ///
  ///타

  List<Map<String, dynamic>> mapInfo = mapInfos;

  bool isButtonEnabled = false;

  bool isUserTypeSelected = false;
  bool isJobStudentSelected = false;
  bool isGenderSelected = false;
  bool isMarriedSelected = false;
  bool isResidenceSelected = false;
  bool isPetSelected = false;
  bool isArea1Selected = false;
  bool isArea2Selected = false;

  late String initialSelectCity = "";

  void checkButtonEnabled() {

    if((initialSelectCity == "") & (selectedCity != null)){
      initialSelectCity = selectedCity!;
    }

    // selectedCity가 변경되었을 경우 selectedCountry와 isArea2Selected 업데이트
    if ((selectedCity != null) & (selectedCity != initialSelectCity)) {
      initialSelectCity = selectedCity!;
      selectedCountry = null;
      isArea2Selected = false;
    }

    if (selectedJobCdType != jobCdType[6]) {
      // 직장인이 아닐 경우 관련 UI 초기화
      selectedAsignCdType = asignCdType[0];
    }

    if (selectedCity == null) {
      // 시/도가 선택되지 않았을 경우 구/군 선택 초기화
      selectedCountry = null;
    }

    if(selectedCity == null){
      isArea1Selected = false;
      isArea2Selected = false;
    }

    if(selectedCountry == null){
      isArea2Selected = false;
    }

    /// 개인/기업
    if (selectedUserType != userType[0]) isUserTypeSelected = true;

    /// 직업/학생/직무명/기타
    if (selectedJobCdType != jobCdType[0]) isJobStudentSelected = true;
    if (selectedJobCdType != jobCdType[0] &&
        selectedAsignCdType != jobCdType[6] &&
        selectedAsignCdType != jobCdType[9]) isJobStudentSelected = true;
    if (selectedJobCdType == jobCdType[6] &&
        selectedAsignCdType == asignCdType[0]) isJobStudentSelected = false;
    if (selectedJobCdType == jobCdType[6] &&
        selectedAsignCdType != asignCdType[0]) isJobStudentSelected = true;

    /// 거주 형태
    if (selectedResidenceType != residenceType[0]) isResidenceSelected = true;

    /// 반려 동물
    if (selectedPetType != petType[0]) isPetSelected = true;

    /// 성별과 결혼 여부
    isGenderSelected = isMaleSelected || isFemaleSelected;
    isMarriedSelected = marriedSelected || unMarriedSelected;

    /// 거주 지역 여부
    if (selectedCity != null) isArea1Selected = true;
    if (selectedCountry != null) isArea2Selected = true;

    setState(() {
      isButtonEnabled = isUserTypeSelected &&
          isJobStudentSelected &&
          isResidenceSelected &&
          isPetSelected &&
          isGenderSelected &&
          isMarriedSelected &&
          isArea1Selected &&
          isArea2Selected;

      print(isArea2Selected);
    });
    print(selectedCity);
    print("${selectedCountry}qwe");
  }

  void checkJobEnabled(String job) {
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
      },
    );
    print(selectedCity);
    print(selectedCountry);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Function to close the dropdown when tapping outside
    void closeDropdown() {
      FocusScope.of(context).requestFocus(FocusNode());
    }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SafeArea(
          child: GestureDetector(
            onTap: closeDropdown,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  key: globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SignupAppBar(currentPage: '2/2'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.circular(10), // 모서리를 둥글게 깎기 위함
                          ),
                          height: 110,
                          alignment: Alignment.center, // 텍스트를 컨테이너 중앙에 배치
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "인터미션은 아래의 입력정보를 바탕으로\n맞춤형 리서치를 제공하고 있습니다.\n신중히 선택해주세요! ✅ \n",
                              textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ),
                      SignupAskLabel(text: '개인/공공기관/기업'),
                      Center(
                        child: CustomDropdownButton(
                          dropdownWidth: screenWidth * 0.9,
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
                      SizedBox(
                        height: 10,
                      ),

                      /// 직업/학생 -> 직장인
                      SignupAskLabel(text: '직업/학생'),
                      Center(
                        child: CustomDropdownButton(
                          dropdownWidth: screenWidth * 0.9,
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
                        Column(
                          children: [
                            SignupAskLabel(text: '담당 업무'),
                            Center(
                              child: CustomDropdownButton(
                                dropdownWidth: screenWidth * 0.9,
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
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),

                      ///직업/학생 -> 기타
                      if (selectedJobCdType == jobCdType[9])
                        SignupAskLabel(text: '직장(기타를 고른 경우)'),
                      if (selectedJobCdType == jobCdType[9])
                        CustomTextFormField(
                          controller: jobController,
                          hintText: '학생(학교명), 직장인(직무) 형식으로 입력해 주세요',
                          onChanged: checkJobEnabled,
                          errorText: isJobValid ? null : jobErrorText,
                        ),
                      if (selectedJobCdType == jobCdType[9])
                        SizedBox(
                          height: 20,
                        ),
                      SignupAskLabel(text: '거주 형태'),
                      Center(
                        child: CustomDropdownButton(
                          dropdownWidth: screenWidth * 0.9,
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
                          dropdownWidth: screenWidth * 0.9,
                          items: petType,
                          hintText: '선택',
                          onItemSelected: (value) {
                            setState(
                              () {
                                selectedPetType = value;
                                if (selectedPetType == '기타') {
                                  raisePet = true;
                                } else {
                                  raisePet = false;
                                }
                              },
                            );
                            checkButtonEnabled();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SignupAskLabel(text: '거주 지역'),
                      // '시/도' 선택에 대한 처리
                      // '시/도' 선택에 대한 처리
                      Center(
                        child: CustomDropdownButton(
                          dropdownWidth: screenWidth * 0.9,
                          items: mapInfo
                              .map((info) => info['name'].toString())
                              .toList(),
                          hintText: '시/도를 선택하세요.',
                          onItemSelected: (value) {
                            setState(() {
                              if (initialSelectCity != value) {

                                selectedCountry = mapInfo.firstWhere((info) =>
                                        info['name'] == value)['countries']
                                    [0]; // 구/군 초기화


                              }
                              selectedCity = value;
                              checkButtonEnabled();
                            });
                          },
                        ),
                      ),

                      // '구/군' 선택에 대한 처리
                      if (selectedCity != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: CustomDropdownButton(
                              key: ValueKey(selectedCity), // selectedCity가 변경될 때마다 새로운 Key 할당
                              dropdownWidth: screenWidth * 0.9,
                              items: (selectedCity == null
                                  ? []
                                  : (mapInfo.firstWhere((info) =>
                                          info['name'] ==
                                          selectedCity)['countries'] as List)
                                      .map((country) => country.toString())
                                      .toList()),
                              hintText: '구/군을 선택하세요.',
                              onItemSelected: (value) {
                                setState(() {
                                  selectedCountry = value;
                                  checkButtonEnabled();
                                });
                              },
                              enabled: selectedCity != null,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      SignupAskLabel(text: '성별'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SignupEitherButton(
                              text: '남성',
                              isSelected: isMaleSelected,
                              onPressed: () {
                                setState(() {
                                  isMaleSelected = true;
                                  isFemaleSelected = false;
                                });
                                checkButtonEnabled();
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
                                checkButtonEnabled();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SignupAskLabel(text: '결혼 여부'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
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
                      ),
                      SizedBox(height: screenHeight * 0.2),
                      LoginNextButton(
                        buttonName: '본인인증 실행하기',
                        isButtonEnabled: isButtonEnabled,
                        onPressed: () {
                          final state = ref.read(signupUserProvider.notifier);
                          state.setGenderCd(
                              isMaleSelected == true ? "남성" : "여성");
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
                          state.setIsSignupAction(false);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CertificationTest(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
