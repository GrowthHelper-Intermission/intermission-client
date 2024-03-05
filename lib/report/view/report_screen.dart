import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/report/component/report_card.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/button/next_button.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/layout/default_layout.dart';
import 'package:intermission_project/report/provider/report_provider.dart';
import 'package:intermission_project/report/model/report_req_model.dart';
import 'package:intermission_project/report/provider/report_req_provider.dart';
import 'package:intermission_project/common/component/render_loading.dart';
import 'package:intermission_project/point/view/point_history_screen.dart';

class UserReportScreen extends ConsumerStatefulWidget {
  static String get routeName => 'report';
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
    _tabController = TabController(length: 2, vsync: this);
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
  void closeDropdown() {
    final _currentFocus = FocusScope.of(context);
    if (!_currentFocus.hasPrimaryFocus) {
      _currentFocus.unfocus();
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      isResize: true,
      title: '문의하기',
      child: GestureDetector(
        onTap: closeDropdown,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              TabBar(
                indicatorColor: PRIMARY_COLOR,
                labelColor: PRIMARY_COLOR,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 깎기 위함
              ),
              height: 90,
              alignment: Alignment.center, // 텍스트를 컨테이너 중앙에 배치
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "인터미션에게 바라는 점이 있다면 써주세요!",
                  textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 3,
                ),
              ),
            ),
          ),
          Text(
            "문의 제목",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            onChanged: (String value) {
              checkButtonEnabled();
            },
            controller: titleController,
            hintText: '제목을 입력해 주세요!',
          ),
          SizedBox(height: 16.0),
          Text(
            "문의 내용",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
          ),
          SizedBox(height: 8.0),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: CustomTextFormFieldWithMaxLength(
              maxLength: 200,
              maxLines: null,
              expands: true,
              onChanged: (String value) {
                checkButtonEnabled();
              },
              controller: contentsController,
              hintText: '욕설이나 비방은 자제해주세요!',
              textAlign: TextAlign.start, // 왼쪽 정렬
              textAlignVertical: TextAlignVertical.top, // 상단 정렬
            ),
          ),
          SizedBox(height: 20),
          NextButton(
            onPressed: isButtonEnabled
                ? () async {
                    ReportReqModel newReport = ReportReqModel(
                      mainTitle: titleController.text.trim(),
                      detail: contentsController.text.trim(),
                    );

                    // Post the report
                    ref
                        .read(reportReqStateNotifierProvider.notifier)
                        .postReport(newReport);
                    print('Report posted successfully');

                    // Show the confirmation dialog
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("알림"),
                            content: Text("등록되었습니다!"),
                            actions: [
                              TextButton(
                                child: Text("확인"),
                                onPressed: () async {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog

                                  // Add a delay before switching tabs
                                  await Future.delayed(
                                      Duration(milliseconds: 500));

                                  // Move to the report history tab
                                  _tabController?.animateTo(1);

                                  // Refresh the report history
                                  ref.refresh(reportProvider);
                                },
                              ),
                            ],
                          );
                        });
                  }
                : null,
            buttonName: '문의하기',
            isButtonEnabled: isButtonEnabled,
          ),
        ],
      ),
    );
  }

  Widget _buildTabContentForHistory() {
    final state = ref.watch(reportProvider);

    if (state is CursorPaginationLoading || state == null) {
      return renderLoading();
    }

    return RefreshIndicator(
      color: PRIMARY_COLOR,
      onRefresh: () async {
        await Future.delayed(
            Duration(seconds: 1)); // 임의로 1초 지연을 줍니다. 필요에 따라 조절하실 수 있습니다.
        ref.refresh(reportProvider);
      },
      child: Column(
        children: [
          _buildReportPage(reportProvider),
        ],
      ),
    );
  }

  Widget _buildReportPage(
      StateNotifierProvider<ReportStateNotifier, CursorPaginationBase>
          provider) {
    return Expanded(
      child: PaginationListView(
        provider: provider,
        itemBuilder: <ReportModel>(BuildContext context, int index, model) {
          return ReportCard.fromModel(model);
        },
      ),
    );
  }

  Widget _buildTabItem(String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2, // 4개의 탭이므로 화면 너비를 4로 나눔
      height: 50,
      child: Center(
        child: Text(
          title,
        ),
      ),
    );
  }
}
