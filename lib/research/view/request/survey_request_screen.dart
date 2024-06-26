import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/component/custom_check_box.dart';
import 'package:intermission_project/common/component/button/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/button/next_button.dart';
import 'package:intermission_project/common/component/common_ask_label.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/type_data.dart';
import 'package:intermission_project/common/layout/default_layout.dart';
import 'package:intermission_project/research/model/survey_req_model.dart';
import 'package:intermission_project/research/provider/survey_req_provider.dart';

class SurveyReqScreen extends ConsumerStatefulWidget {
  const SurveyReqScreen({super.key});

  @override
  _SurveyReqScreenState createState() => _SurveyReqScreenState();
}

class _SurveyReqScreenState extends ConsumerState<SurveyReqScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  void checkButtonEnabled() {
    bool isFieldsValid = true;

    setState(() {
      isButtonEnabled = isFieldsValid;
    });
  }

  bool surveyResChecked = false;
  bool surveyDevChecked = false;
  bool surveyInputChecked = false;

  bool isAgree = false;

  TextEditingController urlController = TextEditingController();
  TextEditingController exceptTimeMinuteController = TextEditingController();
  TextEditingController cntController = TextEditingController();
  TextEditingController screeningController = TextEditingController();
  TextEditingController etcReqCnController = TextEditingController();

  String? selectedTaskTp;

  bool isMatchingChecked = false;
  bool isQuestionChecked = false;
  bool isInsteadChecked = false;

  // Function to close the dropdown when tapping outside
  void closeDropdown() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: DefaultLayout(
        isResize: true,
        title: '설문 의뢰',
        child: GestureDetector(
          onTap: closeDropdown,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAskLabel(text: '작성하시는 분이 하시는 일을 알려주세요'),
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
                    dropdownWidth: screenWidth*0.9,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonAskLabel(text: '설문대상'),
                  Text('무작위면 무작위로 적어주시면 감사하겠습니다. 대상자에 따라 스크리닝 비용 추가됩니다.',
                      style: TextStyle(fontSize: 13, color: GREY_COLOR)),
                  CustomTextFormField(
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                    controller: screeningController,
                    hintText: '20대/30대 반려동물 소유 여성',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonAskLabel(text: '완성된 설문이 있다면 설문 링크'),
                  CustomTextFormField(
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                    controller: urlController,
                    hintText: 'url이 있으시면 적어주세요!',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonAskLabel(text: '설문이 없다면 예상 설문 문항 수 및 예상 응답 시간'),
                  CustomTextFormField(
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                    controller: exceptTimeMinuteController,
                    hintText: '50문항, 30분',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonAskLabel(text: '원하는 인원'),
                  CustomTextFormField(
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                    controller: cntController,
                    hintText: '40명',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonAskLabel(text: '의뢰하시는 서비스를 선택해주세요'),
                  CustomCheckBox(
                    isAgree: surveyResChecked,
                    onChanged: (value) {
                      setState(() {
                        surveyResChecked = value!;
                        checkButtonEnabled();
                      });
                    },
                    title: '설문 응답',
                  ),
                  CustomCheckBox(
                    isAgree: surveyDevChecked,
                    onChanged: (value) {
                      setState(() {
                        surveyDevChecked = value!;
                        checkButtonEnabled();
                      });
                    },
                    title: '설문지 개발',
                  ),
                  CustomCheckBox(
                    isAgree: surveyInputChecked,
                    onChanged: (value) {
                      setState(() {
                        surveyInputChecked = value!;
                        checkButtonEnabled();
                      });
                    },
                    title: '설문 입력',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonAskLabel(text: '기타 요청 사항'),
                  CustomTextFormField(
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                    controller: etcReqCnController,
                    hintText: '추가적인 요청사항 입력',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NextButton(
                    buttonName: '설문조사 의뢰하기',
                    isButtonEnabled: isButtonEnabled,
                    onPressed: () async {
                      SurveyReqModel newSurvey = SurveyReqModel(
                        taskTpCd: selectedTaskTp!,
                        screening: screeningController.text.trim(),
                        completeUrl: urlController.text.trim(),
                        exceptCountTime: exceptTimeMinuteController.text.trim(),
                        researchEntryCnt: cntController.text.trim(),
                        surveyInput: surveyInputChecked ? "Y" : "N",
                        surveyRes: surveyResChecked ? "Y" : "N",
                        surveyDev: surveyDevChecked ? "Y" : "N",
                        isAgree: "Y",
                      );
                      try {
                        ref
                            .read(surveyReqStateNotifierProvider.notifier)
                            .postSurvey(newSurvey);
                        print('Interview posted successfully');

                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text("알림"),
                              content: Text(
                                "등록되었습니다!\n관리자로부터 연락이 갈테니\n잠시만 기다려주세요!",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text("확인"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Navigate to the next screen
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
      ),
    );
  }
}
