// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intermission_project/04.research/research/provider/research_provider.dart';
// import 'package:intermission_project/04.research/research/view/research_screen.dart';
// import 'package:intermission_project/04.research/research_req/model/interview_req_model.dart';
// import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
// import 'package:intermission_project/04.research/research_req/model/survey_req_model.dart';
// import 'package:intermission_project/04.research/research_req/model/tester_req_model.dart';
// import 'package:intermission_project/04.research/research_req/provider/interview_req_provider.dart';
// import 'package:intermission_project/04.research/research_req/provider/research_req_provider.dart';
// import 'package:intermission_project/04.research/research_req/provider/survey_req_provider.dart';
// import 'package:intermission_project/04.research/research_req/provider/tester_req_provider.dart';
// import 'package:intermission_project/common/view/default_layout.dart';
// import 'package:intermission_project/common/view/home_screen.dart';
// import 'package:intermission_project/common/view/root_tab.dart';
//
// class TesterReqScreen extends ConsumerWidget {
//   const TesterReqScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return DefaultLayout(
//       title: '제품/서비스 FGI 모집 및 대행 의뢰',
//       child: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               TesterReqModel testerReqModel = TesterReqModel(
//                 taskTpCd: '대표자',
//                 completeUrl: 'https://docs.google.com/forms/d/e/1FAIpQLScLq4BPS21q1CmeQipv068UyMCYsz9Kxa_3d-8ISF_jlfgByA/viewform',
//                 exceptCountTime: '30문항 20분이야',
//                 compNm: '그로스헬퍼',
//                 preferredTime: '1시간 5명 FGI 같은 날 2회 연속',
//                 researchMethTpCd: '오프라인',
//                 isAgree: 'Y',
//                 researchEntryCnt: '5',
//               );
//               try {
//                 ref
//                     .read(testerReqStateNotifierProvider.notifier)
//                     .postTester(testerReqModel);
//                 print('Research posted successfully');
//
//                 // Show the confirmation dialog
//                 await showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("알림"),
//                       content: Text("등록되었습니다!"),
//                       actions: [
//                         TextButton(
//                           child: Text("확인"),
//                           onPressed: () {
//                             Navigator.of(context).pop(); // Close the dialog
//                             context.goNamed(RootTab
//                                 .routeName); // Navigate to the next screen
//                             ref
//                                 .read(researchProvider.notifier)
//                                 .paginate(forceRefetch: true);
//                             ref.read(interviewProvider.notifier).paginate();
//                             ref.read(surveyProvider.notifier).paginate();
//                             ref.read(testerProvider.notifier).paginate();
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               } catch (e) {
//                 print(e);
//                 print('Error occurred while posting research');
//               }
//             },
//             child: Text('FGI 의뢰'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/model/interview_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/survey_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/tester_req_model.dart';
import 'package:intermission_project/04.research/research_req/provider/interview_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/research_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/survey_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/tester_req_provider.dart';
import 'package:intermission_project/common/component/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/type_data.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/home_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';

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
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: DefaultLayout(
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
                  SignupAskLabel(text: 'FGI 대상'),
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
                  SignupAskLabel(text: '제품/서비스 링크'),
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
                  SignupAskLabel(text: 'FGI 방법(온라인/오프라인)'),
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
                  SignupAskLabel(text: 'FGI 예상 소요 시간, 원하는 인원(최소 5명), 횟수'),
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
                  SignupAskLabel(text: '선호하시는 진행 시간대'),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LoginNextButton(
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
                              content: Text("FGI 등록되었습니다!"),
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
      ),
    );
  }
}
