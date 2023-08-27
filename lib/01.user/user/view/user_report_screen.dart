import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/root_tab.dart';

class UserReportScreen extends ConsumerStatefulWidget {
  const UserReportScreen({super.key});

  @override
  ConsumerState<UserReportScreen> createState() => _UserReportScreenState();
}

class _UserReportScreenState extends ConsumerState<UserReportScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;

  final titleController = TextEditingController();
  final contentsController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 4개의 탭
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void checkButtonEnabled() {
    setState(() {
      isButtonEnabled = titleController.text.trim().isNotEmpty &&
          contentsController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '문의하기',
      child: SingleChildScrollView(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: false,
              tabs: [
                _buildTabItem("문의하기"),
                _buildTabItem("문의내역"),
              ],
            ),
            Container(
              //전체 높이 - appbar + tabbar
              height: MediaQuery.of(context).size.height - kToolbarHeight - 50,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTabContentForReport(),
                  _buildTabContentForHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContentForReport() {
    // 첫 번째 탭의 내용
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("문의 제목"),
          SizedBox(height: 8.0),
          CustomTextFormField(
            onChanged: (String value) {
              checkButtonEnabled();
            },
            controller: titleController,
            hintText: '제목을 입력해 주세요',
          ),
          SizedBox(height: 16.0),
          Text("문의 내용"),
          SizedBox(height: 8.0),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: CustomTextFormField(
              maxLines: null,
              expands: true,
              onChanged: (String value) {
                checkButtonEnabled();
              },
              controller: contentsController,
              hintText: '문의내용을 작성해 주세요',
            ),
          ),
          SizedBox(height: 50,),
          LoginNextButton(
              onPressed: isButtonEnabled
                  ? () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("알림"),
                            content: Text("등록되었습니다!"),
                            actions: [
                              TextButton(
                                child: Text("확인"),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => RootTab(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  : null,
              buttonName: '등록',
              isButtonEnabled: isButtonEnabled)
        ],
      ),
    );
  }

  Widget _buildTabContentForHistory() {
    // 두 번째 탭의 내용
    return Center(
      child: Text("문의 내역을 여기에 표시합니다."),
    );
  }

  Widget _buildTabItem(String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2, // 4개의 탭이므로 화면 너비를 4로 나눔
      height: 50,
      child: Center(child: Text(title)),
    );
  }
}
