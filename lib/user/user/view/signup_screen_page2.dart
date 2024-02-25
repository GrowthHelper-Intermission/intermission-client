import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/certification/certification_test.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_either_button.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/type_data.dart';
import 'package:intermission_project/user/user/provider/signup_user_provider.dart';

class SignupScreenPage2 extends ConsumerStatefulWidget {
  static String get routeName => 'signup2';
  const SignupScreenPage2({super.key});

  @override
  ConsumerState<SignupScreenPage2> createState() => _SignupScreenPage2State();
}

class _SignupScreenPage2State extends ConsumerState<SignupScreenPage2> {
  final globalKey = GlobalKey<FormState>();
  TextEditingController residenceAreaController = TextEditingController();
  TextEditingController possibleAreaController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  bool marriedSelected = false;
  bool unMarriedSelected = false;
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  bool isJobValid = false;

  String? selectedUserType;
  String? selectedCity;
  String? selectedCountry;

  String? selectedJobCdType;

  String? selectedIndustry;
  String? selectedIndustryDetailType;
  String? selectedTaskType;

  bool isAreaValid = false;

  final jobCdType = jobCdTypes;


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
  String? jobErrorText;

  /// 10(초등학생), 11(중학생), 12(고등학생), 13(대학생), 14(대학원생),
  /// 15(직장인), 16(유학생), 17(공무원), 18(군인), 99(기타)
  ///
  ///타

  List<Map<String, dynamic>> mapInfo = mapInfos;

  List<Map<String, dynamic>> industryInfo = industryInfos;

  bool isButtonEnabled = false;
  bool isGenderSelected = false;
  bool isMarriedSelected = false;
  bool isResidenceSelected = false;
  bool isArea1Selected = false;
  bool isArea2Selected = false;
  bool isJobSelected = false;
  bool isTaskSelected = false;
  bool isIndustrySelected = false;
  bool isIndustryDetailSelected = false;

  late String initialSelectCity = "";

  late String initialIndustry = "";

  void checkButtonEnabled() {
    // selectedJobCdType이 '직장인'이 아니면 관련 상태 초기화

    if (selectedJobCdType == jobCdType[10] && selectedIndustry == null) {
      isIndustrySelected = false;
      isIndustryDetailSelected = false;
    }

    if (selectedIndustry != null && selectedIndustryDetailType == null) {
      isIndustryDetailSelected = false;
    }

    if (selectedJobCdType == jobCdType[8] && selectedTaskType == null) {
      isTaskSelected = false;
    }

    // 직장
    if (selectedJobCdType != jobCdType[8]) {
      isTaskSelected = true;
    }

    if (selectedJobCdType != jobCdType[10]) {
      isIndustrySelected = true;
      isIndustryDetailSelected = true;
    }

    if (selectedJobCdType != jobCdType[8]) {
      selectedTaskType = null;
    }

    // selectedJobCdType이 '기타'가 아니면 관련 상태 초기화
    if (selectedJobCdType != jobCdType[10]) {
      selectedIndustry = null;
      selectedIndustryDetailType = null;
    }

    // selectedCity가 변경되었을 경우 selectedCountry와 isArea2Selected 업데이트
    if ((selectedCity != null) && (selectedCity != initialSelectCity)) {
      initialSelectCity = selectedCity!;
      selectedCountry = null;
      isArea2Selected = false;
    }

    // 시/도가 선택되지 않았을 경우 구/군 선택 초기화
    if (selectedCity == null) {
      selectedCountry = null;
      isArea1Selected = false;
      isArea2Selected = false;
    }

    // 기타 상태 업데이트
    isJobSelected = selectedJobCdType != jobCdType[0];
    isResidenceSelected = selectedResidenceType != residenceType[0];
    isGenderSelected = isMaleSelected || isFemaleSelected;
    isMarriedSelected = marriedSelected || unMarriedSelected;
    isArea1Selected = selectedCity != null;
    isArea2Selected = selectedCountry != null;

    // 버튼 활성화 상태 결정
    isButtonEnabled = isResidenceSelected &&
        isGenderSelected &&
        isMarriedSelected &&
        isArea1Selected &&
        isArea2Selected &&
        isJobSelected &&
        isTaskSelected &&
        isIndustrySelected &&
        isIndustryDetailSelected;

    // 상태 업데이트 반영
    setState(() {});
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
        selectedResidenceType = residenceType[0];
        selectedJobCdType = jobCdType[0];
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

                      SignupAskLabel(text: '거주 형태'),
                      Center(
                        child: CustomDropdownButton(
                          dropdownWidth: screenWidth * 0.9,
                          items: residenceType,
                          hintText: '선택',
                          onItemSelected: (value) {
                            setState(() {
                              selectedResidenceType = value;
                            });
                            checkButtonEnabled();
                          },
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      SignupAskLabel(text: '거주 지역'),
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
                              key: ValueKey(
                                  selectedCity), // selectedCity가 변경될 때마다 새로운 Key 할당
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
                      SizedBox(
                        height: 20,
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
                            isJobSelected = true;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (selectedJobCdType == jobCdType[8])
                        Column(
                          children: [
                            SignupAskLabel(text: '상세 직업 분야'),
                            Center(
                              child: CustomDropdownButton(
                                dropdownWidth: screenWidth * 0.9,
                                items: taskTypes,
                                hintText: '선택',
                                onItemSelected: (value) {
                                  setState(
                                    () {
                                      selectedTaskType = value;
                                    },
                                  );
                                  isTaskSelected = true;
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
                      if (selectedJobCdType == jobCdType[10])
                        SignupAskLabel(text: '사업 종사 분야'),
                      if (selectedJobCdType == jobCdType[10])
                        Center(
                          child: CustomDropdownButton(
                            dropdownWidth: screenWidth * 0.9,
                            items: industryInfos
                                .map((info) => info['industry'].toString())
                                .toList(),
                            hintText: '종사 분야를 선택해 주세요!',
                            onItemSelected: (value) {
                              setState(() {
                                print('ss');
                                if (initialIndustry != value) {
                                  print('kk');
                                  selectedIndustryDetailType =
                                      industryInfos.firstWhere((info) =>
                                          info['industry'] ==
                                          value)['detailIndustry'][0];
                                }
                                print(selectedIndustry);
                                selectedIndustry = value;
                                isIndustrySelected = true;
                                checkButtonEnabled();
                              });
                            },
                          ),
                        ),
                      if (selectedJobCdType == jobCdType[10])
                        SizedBox(
                          height: 20,
                        ),
                      if (selectedIndustry != null)
                        SignupAskLabel(text: '상세 사업 종사 분야'),
                      if (selectedIndustry != null)
                        Center(
                          child: CustomDropdownButton(
                            key: ValueKey(
                                selectedIndustry), // selectedCity가 변경될 때마다 새로운 Key 할당
                            dropdownWidth: screenWidth * 0.9,
                            items: (selectedIndustry == null
                                ? []
                                : (industryInfo.firstWhere((info) =>
                                            info['industry'] ==
                                            selectedIndustry)['detailIndustry']
                                        as List)
                                    .map((industry) => industry.toString())
                                    .toList()),
                            hintText: '상세 종사 분야를 선택해 주세요!',
                            onItemSelected: (value) {
                              setState(() {
                                selectedIndustryDetailType = value;
                                isIndustryDetailSelected = true;
                                checkButtonEnabled();
                              });
                            },
                            enabled: selectedIndustryDetailType != null,
                          ),
                        ),
                      if (selectedIndustry != null)
                        SizedBox(
                          height: 20,
                        ),
                      SizedBox(height: screenHeight * 0.3),
                      LoginNextButton(
                        buttonName: '본인인증 실행하기',
                        isButtonEnabled: isButtonEnabled,
                        onPressed: () {
                          final state = ref.read(signupUserProvider.notifier);
                          state.setGenderCd(
                              isMaleSelected == true ? "남성" : "여성");
                          state.setWedCd(marriedSelected == true ? "기혼" : "미혼");
                          state.setHouseCd(selectedResidenceType);
                          state.setJobCd(selectedJobCdType);
                          state.setOccpSidoCd(selectedCity);
                          state.setOccpSigunguCd(selectedCountry);
                          state.setUserCd(selectedUserType);
                          state.setTaskCd(selectedTaskType ?? '없음');
                          state.setIndustryCd(selectedIndustry ?? '없음');
                          state.setIndustryDetail(
                              selectedIndustryDetailType ?? '없음');
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
