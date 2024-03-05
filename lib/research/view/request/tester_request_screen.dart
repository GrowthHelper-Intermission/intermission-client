import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/common/component/button/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/button/next_button.dart';
import 'package:intermission_project/common/component/common_ask_label.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/type_data.dart';
import 'package:intermission_project/common/layout/default_layout.dart';
import 'package:intermission_project/common/view/home_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/research/model/tester_req_model.dart';
import 'package:intermission_project/research/provider/research_provider.dart';
import 'package:intermission_project/research/provider/tester_req_provider.dart';

class TesterReqScreen extends ConsumerStatefulWidget {
  @override
  _TesterReqScreenState createState() => _TesterReqScreenState();
}

class _TesterReqScreenState extends ConsumerState<TesterReqScreen> {
  bool isButtonEnabled = false;

  void checkButtonEnabled() {
    bool isTaskSelected =
        selectedTaskTp != null && selectedTaskTp != '선택';

    bool isCompNmFilled =
        compNmController.text.trim().isNotEmpty;

    bool isTargetFilled =
        targetController.text.trim().isNotEmpty;

    bool isTimeSelected =
        selectedTimeTp != null && selectedTimeTp != '선택';

    bool isUrlFilled =
        urlController.text.trim().isNotEmpty;

    bool isMethodFilled =
        fgiMethodController.text.trim().isNotEmpty; // 인터뷰 예상 소요 시간

    bool isFieldsValid = isTaskSelected && isCompNmFilled && isTargetFilled &&
        isTimeSelected && isUrlFilled && isMethodFilled;

    setState(() {
      isButtonEnabled = isFieldsValid;
    });
  }

  TextEditingController urlController = TextEditingController();
  TextEditingController compNmController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController fgiMethodController = TextEditingController();
  TextEditingController exceptTimeCntController = TextEditingController();

  String? selectedTaskTp;
  String? selectedTimeTp;

  void closeDropdown() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: DefaultLayout(
        isResize: true,
        title: '제품/서비스 FGI 모집 및 대행 의뢰',
        child: GestureDetector(
          onTap: closeDropdown,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.all(8.0),
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
                  CommonAskLabel(text: '선호하시는 진행 시간대'),
                  CustomDropdownButton(
                    items: timeTypes,
                    hintText: '선택',
                    onItemSelected: (value) {
                      setState(
                            () {
                          selectedTimeTp = value;
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
                  CommonAskLabel(text: '회사명 / 아이템명'),
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
                  CommonAskLabel(text: 'FGI 대상'),
                  Text(
                    '좁은 타겟일 경우 비용이 추가됩니다.',
                    style: TextStyle(fontSize: 13, color: GREY_COLOR),
                  ),
                  CustomTextFormField(
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                    controller: targetController,
                    hintText: '원하는 FGI 특성을 기재해주세요!',
                  ),
                  SizedBox(height: 20,),
                  CommonAskLabel(text: '제품/서비스 링크'),
                  CustomTextFormField(
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                    controller: urlController,
                    hintText: 'url이 있으시면 기재해주세요!',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonAskLabel(text: 'FGI 방법(온라인/오프라인)'),
                  Text(
                    '오프라인일 경우 공간 대여를 원하는지(무료),\n지정된 장소가 있는지 기재해주시면 됩니다!',
                    style: TextStyle(fontSize: 13, color: GREY_COLOR),
                  ),
                  CustomTextFormField(
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                    controller: fgiMethodController,
                    hintText: '30분',
                  ),
                  SizedBox(height: 20,),
                  CommonAskLabel(text: 'FGI 예상 소요 시간, 원하는 인원(최소 5명), 횟수'),
                  Text(
                    '1시간 5명 FGI 같은 날 2회 연속\n2시간 7명 FGI  1회',
                    style: TextStyle(fontSize: 13, color: GREY_COLOR),
                  ),
                  CustomTextFormField(
                    onChanged: (String value) {
                      checkButtonEnabled();
                    },
                    controller: exceptTimeCntController,
                    hintText: '1시간 5명 FGI, 1/1 2회 연속 원해요!',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NextButton(
                    buttonName: 'FGI 의뢰하기',
                    isButtonEnabled: isButtonEnabled,
                    onPressed: () async {
                      TesterReqModel testerReqModel = TesterReqModel(
                        taskTpCd: selectedTaskTp!,
                        compNm: compNmController.text.trim(),
                        completeUrl: urlController.text.trim(),
                        fgiTarget: targetController.text.trim(),
                        fgiMethod: fgiMethodController.text.trim(),
                        exceptTimeCnt: exceptTimeCntController.text.trim(),
                        preferredTime: selectedTimeTp!,
                      );
                      try {
                        ref
                            .read(testerReqStateNotifierProvider.notifier)
                            .postTester(testerReqModel);
                        print('Research posted successfully');

                        ref.read(researchProvider.notifier).getTopThreeResearches();

                        // Show the confirmation dialog
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
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
                                        .pop(); // Close the dialog
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
