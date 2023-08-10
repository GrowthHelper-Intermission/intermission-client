import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
  final jobCdType = [
    '선택',
    '초등 학생',
    '중학생',
    '고등 학생',
    '대학(원)생',
    '유학생',
    '직장인',
    '공무원',
    '사업자',
    '기타',
  ];
  String? selectedJobCdType;

  final petType = [
    '선택',
    '강아지',
    '고양이',
    '기타',
  ];

  String? selectedPetType;

  final asignCdType = [
    '선택',
    '일반 사무직',
    '재무/경리',
    '영업직',
    '홍보 마케팅',
    '기획',
    '개발',
    '기타',
  ];

  List<Map<String, dynamic>> mapInfo = [
    {
      "name": "서울특별시",
      "countries": [
        "강남구",
        "강동구",
        "강북구",
        "강서구",
        "관악구",
        "광진구",
        "구로구",
        "금천구",
        "노원구",
        "도봉구",
        "동대문구",
        "동작구",
        "마포구",
        "서대문구",
        "서초구",
        "성동구",
        "성북구",
        "송파구",
        "양천구",
        "영등포구",
        "용산구",
        "은평구",
        "종로구",
        "중구",
        "중랑구"
      ]
    },
    {
      "name": "부산광역시",
      "countries": [
        "강서구",
        "금정구",
        "기장군",
        "남구",
        "동구",
        "동래구",
        "부산진구",
        "북구",
        "사상구",
        "사하구",
        "서구",
        "수영구",
        "연제구",
        "영도구",
        "중구",
        "해운대구"
      ]
    },
    {
      "name": "대구광역시",
      "countries": ["남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"]
    },
    {
      "name": "인천광역시",
      "countries": [
        "강화군",
        "계양구",
        "남구",
        "남동구",
        "동구",
        "부평구",
        "서구",
        "연수구",
        "옹진군",
        "중구"
      ]
    },
    {
      "name": "광주광역시",
      "countries": ["광산구", "남구", "동구", "북구", "서구"]
    },
    {
      "name": "대전광역시",
      "countries": ["대덕구", "동구", "서구", "유성구", "중구"]
    },
    {
      "name": "울산광역시",
      "countries": ["남구", "동구", "북구", "울주군", "중구"]
    },
    {
      "name": "경기도",
      "countries": [
        "가평군",
        "고양시 덕양구",
        "고양시 일산동구",
        "고양시 일산서구",
        "과천시",
        "광명시",
        "광주시",
        "구리시",
        "군포시",
        "김포시",
        "남양주시",
        "동두천시",
        "부천시 소사구",
        "부천시 오정구",
        "부천시 원미구",
        "성남시 분당구",
        "성남시 수정구",
        "성남시 중원구",
        "수원시 권선구",
        "수원시 영통구",
        "수원시 장안구",
        "수원시 팔달구",
        "시흥시",
        "안산시 단원구",
        "안산시 상록구",
        "안성시",
        "안양시 동안구",
        "안양시 만안구",
        "양주시",
        "양평군",
        "여주군",
        "연천군",
        "오산시",
        "용인시 기흥구",
        "용인시 수지구",
        "용인시 처인구",
        "의왕시",
        "의정부시",
        "이천시",
        "파주시",
        "평택시",
        "포천시",
        "하남시",
        "화성시"
      ]
    },
    {
      "name": "강원도",
      "countries": [
        "강릉시",
        "고성군",
        "동해시",
        "삼척시",
        "속초시",
        "양구군",
        "양양군",
        "영월군",
        "원주시",
        "인제군",
        "정선군",
        "철원군",
        "춘천시",
        "태백시",
        "평창군",
        "홍천군",
        "화천군",
        "횡성군"
      ]
    },
    {
      "name": "충청북도",
      "countries": [
        "괴산군",
        "단양군",
        "보은군",
        "영동군",
        "옥천군",
        "음성군",
        "제천시",
        "증평군",
        "진천군",
        "청원군",
        "청주시 상당구",
        "청주시 흥덕구",
        "충주시"
      ]
    },
    {
      "name": "충청남도",
      "countries": [
        "계룡시",
        "공주시",
        "금산군",
        "논산시",
        "당진시",
        "보령시",
        "부여군",
        "서산시",
        "서천군",
        "아산시",
        "연기군",
        "예산군",
        "천안시 동남구",
        "천안시 서북구",
        "청양군",
        "태안군",
        "홍성군"
      ]
    },
    {
      "name": "전라북도",
      "countries": [
        "고창군",
        "군산시",
        "김제시",
        "남원시",
        "무주군",
        "부안군",
        "순창군",
        "완주군",
        "익산시",
        "임실군",
        "장수군",
        "전주시 덕진구",
        "전주시 완산구",
        "정읍시",
        "진안군"
      ]
    },
    {
      "name": "전라남도",
      "countries": [
        "강진군",
        "고흥군",
        "곡성군",
        "광양시",
        "구례군",
        "나주시",
        "담양군",
        "목포시",
        "무안군",
        "보성군",
        "순천시",
        "신안군",
        "여수시",
        "영광군",
        "영암군",
        "완도군",
        "장성군",
        "장흥군",
        "진도군",
        "함평군",
        "해남군",
        "화순군"
      ]
    },
    {
      "name": "경상북도",
      "countries": [
        "경산시",
        "경주시",
        "고령군",
        "구미시",
        "군위군",
        "김천시",
        "문경시",
        "봉화군",
        "상주시",
        "성주군",
        "안동시",
        "영덕군",
        "영양군",
        "영주시",
        "영천시",
        "예천군",
        "울릉군",
        "울진군",
        "의성군",
        "청도군",
        "청송군",
        "칠곡군",
        "포항시 남구",
        "포항시 북구"
      ]
    },
    {
      "name": "경상남도",
      "countries": [
        "거제시",
        "거창군",
        "고성군",
        "김해시",
        "남해군",
        "밀양시",
        "사천시",
        "산청군",
        "양산시",
        "의령군",
        "진주시",
        "창녕군",
        "창원시 마산합포구",
        "창원시 마산회원구",
        "창원시 성산구",
        "창원시 의창구",
        "창원시 진해구",
        "통영시",
        "하동군",
        "함안군",
        "함양군",
        "합천군"
      ]
    },
    {
      "name": "제주특별자치도",
      "countries": ["서귀포시", "제주시"]
    },
    {
      "name": "세종시",
      "countries": ["세종시"]
    },
  ];

  String? selectedAsignCdType;
  String? selectedCity;
  String? selectedCountry;
  String? intvSelectedCity;
  String? intvSelectedCountry;

  bool isButtonEnabled = false;

  void checkButtonEnabled() {
    bool isMarriedSelected = marriedSelected || unMarriedSelected; //결혼 여부
    bool isRaisingPetSelected = (raisePet && selectedPetType != petType[0]) ||
        raiseNoPet; //반려동물을 키우는지, 키운다면 어떤 종류인지 기입했는가까지,
    // bool isRaisingPetSelected = selectedPetType != petType[0];

    bool isResidenceTypeSelected =
        selectedResidenceType != residenceType[0]; //거주 형태
    bool isJobSelected = selectedJobCdType != jobCdType[0];
    bool isSelectedCity = selectedCity != null;
    bool isSelectedCountry = selectedCountry != null;

    bool isFieldsValid = isMarriedSelected &&
        isRaisingPetSelected &&
        isResidenceTypeSelected &&
        isJobSelected;
    setState(() {
      isButtonEnabled = isFieldsValid && isSelectedCity && isSelectedCountry;
    });
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
    final initialState = ref.read(userMeProvider);  // userMeProvider의 상태를 가져옴
    setState(
      () {
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
                        // errorText:
                        // raisePet && raisePetController.text.trim().isEmpty
                        //     ? '반려동물을 입력해 주세요'
                        //     : null,
                        enable: raisePet,
                      ),
                    SignupAskLabel(text: '거주 지역'),
                    CustomDropdownButton(
                      items: mapInfo.map((info) => info['name'].toString()).toList(),
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
                          : (mapInfo.firstWhere((info) => info['name'] == selectedCity)['countries'] as List).map((country) => country.toString()).toList()),
                      hintText: '구/군을 선택하세요.',
                      onItemSelected: (value) {
                        setState(() {
                          selectedCountry = value;
                          checkButtonEnabled();
                        });
                      },
                      enabled: selectedCity != null,  // 이 부분 추가
                      errorText: "시/도를 먼저 선택해주세요!",  // 이 부분 추가
                    ),
                    SizedBox(height: 20,),
                    // CustomTextFormField(
                    //   controller: residenceAreaController,
                    //   hintText: '구까지 입력해 주세요',
                    //   onChanged: (String value) {
                    //     setState(() {});
                    //     checkAreaEnabled();
                    //   },
                    //   errorText: isAreaValid ? null : residenceAreaErrorText,
                    // ),
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
                    CustomDropdownButton(
                      items: mapInfo.map((info) => info['name'].toString()).toList(),
                      hintText: '시/도를 선택하세요.',
                      onItemSelected: (value) {
                        setState(() {
                          intvSelectedCity = value;
                          intvSelectedCountry = null;
                          checkButtonEnabled();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    CustomDropdownButton(
                      items: (intvSelectedCity == null
                          ? []
                          : (mapInfo.firstWhere((info) => info['name'] == intvSelectedCity)['countries'] as List).map((country) => country.toString()).toList()),
                      hintText: '구/군을 선택하세요.',
                      onItemSelected: (value) {
                        setState(() {
                          intvSelectedCountry = value;
                          checkButtonEnabled();
                        });
                      },
                      enabled: intvSelectedCity != null,  // 이 부분 추가
                      errorText: "시/도를 먼저 선택해주세요!",  // 이 부분 추가
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    LoginNextButton(
                      buttonName: '다음',
                      isButtonEnabled: isButtonEnabled,
                      onPressed: () {
                        ref.read(userMeProvider.notifier).updateUser(
                              wedTpCd: marriedSelected == true ? "M" : "F",
                              housTpCd: selectedResidenceType,
                              petYn: raisePet == true ? "Y" : "N",
                              petTpCd: selectedPetType,
                              petNm: raisePetController.text.trim(),
                              asignJobCd: selectedAsignCdType,
                              jobCd: selectedJobCdType,
                              jobNm: jobController.text.trim(),
                              occpSidoCd: selectedCity,
                              occpSigunguCd: selectedCountry,
                              intvSidoCd: intvSelectedCity,
                              intvSigunguCd: intvSelectedCountry,
                            );
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
