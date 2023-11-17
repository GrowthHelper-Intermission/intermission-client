import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page1.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/model/interview_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/provider/interview_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/research_req_provider.dart';
import 'package:intermission_project/04.research/research_req/view/survey_request_screen.dart';
import 'package:intermission_project/common/component/custom_check_box.dart';
import 'package:intermission_project/common/component/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_long_ask_label.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/type_data.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/home_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';

class InterviewReqScreen extends ConsumerStatefulWidget {
  @override
  _InterviewReqScreenState createState() => _InterviewReqScreenState();
}

class _InterviewReqScreenState extends ConsumerState<InterviewReqScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  void checkButtonEnabled() {
    bool isTaskSelected =
        selectedTaskTp != null && selectedTaskTp != '선택'; // '선택'일 때 비활성화 조건 추가
    bool isCompNmFilled =
        compNmController.text.trim().isNotEmpty; // 회사명 또는 아이템명
    bool isItemOneLineFilled =
        itemOneLineController.text.trim().isNotEmpty; // 아이템 한 줄 소개
    bool isResearchMethodFilled =
        researchMethTpCdController.text.trim().isNotEmpty; // 인터뷰 방법
    bool isExceptTimeFilled =
        exceptTimeMinuteController.text.trim().isNotEmpty; // 인터뷰 예상 소요 시간
    bool isRewardFilled = rewardController.text.trim().isNotEmpty; // 인터뷰 보상
    bool isWhatYouWantFilled =
        whatYouWantController.text.trim().isNotEmpty; // 원하는 인터뷰이 특성
    bool isCntFilled = cntController.text.trim().isNotEmpty; // 원하는 인원
    bool isServiceSelected = isMatchingChecked ||
        isQuestionChecked ||
        isInsteadChecked; // 의뢰하시는 서비스 선택 여부

    bool isFieldsValid = isTaskSelected &&
        isCompNmFilled &&
        isItemOneLineFilled &&
        isResearchMethodFilled &&
        isExceptTimeFilled &&
        isRewardFilled &&
        isWhatYouWantFilled &&
        isCntFilled &&
        isServiceSelected;

    setState(() {
      isButtonEnabled = isFieldsValid;
    });
  }

  TextEditingController compNmController = TextEditingController();
  TextEditingController itemOneLineController = TextEditingController();
  TextEditingController interviewPurposeController = TextEditingController();
  TextEditingController researchMethTpCdController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController whatYouWantController = TextEditingController();
  TextEditingController exceptTimeMinuteController = TextEditingController();
  TextEditingController cntController = TextEditingController();
  TextEditingController etcReqCn = TextEditingController();

  String? selectedTaskTp;

  bool isMatchingChecked = false;
  bool isQuestionChecked = false;
  bool isInsteadChecked = false;

  void closeDropdown() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '인터뷰이 매칭 요청서',
      child: GestureDetector(
        onTap: closeDropdown,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignupAskLabel(text: '작성하시는 분이 하시는 일을 알려주세요'),
                CustomDropdownButton(
                  items: taskTpOptions,
                  hintText: '선택',
                  onItemSelected: (value) {
                    setState(
                      () {
                        selectedTaskTp = value;
                        checkButtonEnabled();
                      },
                    );
                    checkButtonEnabled();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '회사명 / 아이템명'),
                Text(
                  '회사명이 없다면 아이템명만 작성해주시면 됩니다!',
                  style: TextStyle(fontSize: 13, color: GREY_COLOR),
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    checkButtonEnabled();
                  },
                  controller: compNmController,
                  hintText: '그로스 헬퍼/렌터카 경험 인터뷰',
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '아이템 한 줄 소개'),
                CustomTextFormField(
                  onChanged: (String value) {
                    checkButtonEnabled();
                  },
                  controller: itemOneLineController,
                  hintText: '그로스 헬퍼/렌터카 경험 인터뷰',
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '인터뷰 방법'),
                Text(
                  '온라인인지 오프라인인지. 오프라인일 경우 인터뷰이가 있는 장소로\n일정 조율해서 가는지 아니면 지정된 장소로 가야하는지 기재 부탁드립니다.',
                  style: TextStyle(fontSize: 13, color: GREY_COLOR),
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    checkButtonEnabled();
                  },
                  controller: researchMethTpCdController,
                  hintText: '오프라인, 서울 중구',
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '인터뷰 예상 소요 시간'),
                CustomTextFormField(
                  onChanged: (String value) {
                    checkButtonEnabled();
                  },
                  controller: exceptTimeMinuteController,
                  hintText: '30분',
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '인터뷰 보상'),
                CustomTextFormField(
                  onChanged: (String value) {
                    checkButtonEnabled();
                  },
                  controller: rewardController,
                  hintText: '5000원',
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '원하는 인터뷰이 특성'),
                Text(
                  '나이/성별/거주지에 관한 것 등의 자세할수록 좋습니다!',
                  style: TextStyle(fontSize: 13, color: GREY_COLOR),
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    checkButtonEnabled();
                  },
                  controller: whatYouWantController,
                  hintText: '20대/30대/남성/크로스핏',
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '원하는 인원'),
                CustomTextFormField(
                  onChanged: (String value) {
                    checkButtonEnabled();
                  },
                  controller: cntController,
                  hintText: '10명',
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '기타 요청 사항'),
                CustomTextFormField(
                  onChanged: (String value) {
                    checkButtonEnabled();
                  },
                  controller: etcReqCn,
                  hintText: '추가적인 요청사항 입력',
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '의뢰하시는 서비스를 선택해주세요'),
                CustomCheckBox(
                  isAgree: isMatchingChecked,
                  onChanged: (value) {
                    setState(() {
                      isMatchingChecked = value!;
                      checkButtonEnabled();
                    });
                  },
                  title: '인터뷰이 매칭',
                ),
                CustomCheckBox(
                  isAgree: isQuestionChecked,
                  onChanged: (value) {
                    setState(() {
                      isQuestionChecked = value!;
                      checkButtonEnabled();
                    });
                  },
                  title: '인터뷰 질문 개발',
                ),
                CustomCheckBox(
                  isAgree: isInsteadChecked,
                  onChanged: (value) {
                    setState(() {
                      isInsteadChecked = value!;
                      checkButtonEnabled();
                    });
                  },
                  title: '인터뷰 진행 대행',
                ),
                SizedBox(
                  height: 20,
                ),
                SignupAskLabel(text: '질문 개발, 진행 대행 의뢰시 인터뷰 목적 기재'),
                Text(
                  '질문을 대신하여 개발해 드립니다!',
                  style: TextStyle(fontSize: 13, color: GREY_COLOR),
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    checkButtonEnabled();
                  },
                  controller: interviewPurposeController,
                  hintText: '20대/30대/남성/크로스핏',
                ),
                SizedBox(
                  height: 20,
                ),
                LoginNextButton(
                  buttonName: '인터뷰 의뢰하기',
                  isButtonEnabled: isButtonEnabled,
                  onPressed: () async {
                    InterviewReqModel newInterview = InterviewReqModel(
                      taskTpCd: selectedTaskTp!,
                      compNm: compNmController.text.trim().toString(),
                      itemOneLine: itemOneLineController.text.trim().toString(),
                      interviewMethTpCd:
                          researchMethTpCdController.text.trim().toString(),
                      exceptTime:
                          exceptTimeMinuteController.text.trim().toString(),
                      interviewRewdAmt: rewardController.text.trim().toString(),
                      whatYouWant: whatYouWantController.text.trim().toString(),
                      interviewEntryCnt: cntController.text.trim().toString(),
                      etcReqCn: etcReqCn.text.trim().toString(),
                      matching: isMatchingChecked ? "Y" : "N",
                      question: isQuestionChecked ? "Y" : "N",
                      instead: isInsteadChecked ? "Y" : "N",
                      questionDetail:
                          interviewPurposeController.text.trim().toString(),
                      isAgree: "Y",
                    );
                    try {
                      ref
                          .read(interviewReqStateNotifierProvider.notifier)
                          .postInterview(newInterview);
                      print('Research posted successfully');

                      ref.read(researchProvider.notifier).getTopThreeResearches();

                      // Show the confirmation dialog
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text("알림"),
                            content: Text("등록되었습니다!"),
                            actions: [
                              TextButton(
                                child: Text("확인"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  // context.goNamed(RootTab
                                  //     .routeName); // Navigate to the next screen
                                  // ref
                                  //     .read(researchProvider.notifier)
                                  //     .paginate(forceRefetch: true);
                                  // ref
                                  //     .read(interviewProvider.notifier)
                                  //     .paginate();
                                  // ref.read(surveyProvider.notifier).paginate();
                                  // ref.read(testerProvider.notifier).paginate();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      print(e);
                      print('Error occurred while posting research');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
