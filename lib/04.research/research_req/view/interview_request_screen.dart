import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/model/interview_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/provider/interview_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/research_req_provider.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/home_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';

// class InterviewReqScreen extends ConsumerWidget {
//   // static String get routeName => 'request';
//   const InterviewReqScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return DefaultLayout(
//       title: '인터뷰 등록',
//       child: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               InterviewReqModel newInterview = InterviewReqModel(
//                 taskTpCd: '대표자',
//                 compNm: '그로스 헬퍼',
//                 itemOneLine: '아이템 한줄 소개',
//                 researchMethTpCd: '오프라인',
//                 exceptTime: '2',
//                 researchRewdAmt: '30000원',
//                 whatYouWant: 'whatYouWant',
//                 researchEntryCnt: '5',
//                 etcReqCn: '기타 요청사항들',
//                 matching: 'Y',
//                 question: 'Y',
//                 instead: 'N',
//                 questionDetail: 'questionDetail',
//                 isAgree: 'Y',
//               );
//               try {
//                 ref
//                     .read(interviewReqStateNotifierProvider.notifier)
//                     .postInterview(newInterview);
//                 print('Research posted successfully');
//
//                 // ref.read(researchProvider.notifier).getTopThreeResearches();
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
//             child: Text('인터뷰 의뢰'),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class InterviewReqScreen extends StatefulWidget {
  @override
  _InterviewReqScreenState createState() => _InterviewReqScreenState();
}

class _InterviewReqScreenState extends State<InterviewReqScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController compNmController = TextEditingController();
  TextEditingController itemOneLineController = TextEditingController();
  TextEditingController interviewPurposeController = TextEditingController();

  List<String> taskTpOptions = ['대표자', 'PM/PO', 'UX 리서처', '고객개발팀', '밝히기싫다'];
  String? selectedTaskTp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('인터뷰 등록')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTaskTpDropdown(),
              TextFormField(
                controller: compNmController,
                decoration: InputDecoration(labelText: '회사명'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '회사명을 입력해주세요.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: itemOneLineController,
                decoration: InputDecoration(labelText: '한 줄 설명'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '한 줄 설명을 입력해주세요.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: interviewPurposeController,
                decoration: InputDecoration(labelText: '인터뷰 목적'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '인터뷰 목적을 입력해주세요.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('인터뷰 의뢰하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskTpDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedTaskTp,
      onChanged: (String? newValue) {
        setState(() {
          selectedTaskTp = newValue;
        });
      },
      items: taskTpOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(labelText: '업무 유형 선택'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '업무 유형을 선택해주세요.';
        }
        return null;
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // 서버에 등록하는 코드를 여기에 작성합니다.
      // 예: 서버 API를 호출하여 데이터를 저장합니다.
    }
  }
}
