import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/provider/join_provider.dart';
import 'package:intermission_project/01.user/user/provider/point_provider.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/04.research/research/component/research_detail_components.dart';
import 'package:intermission_project/04.research/research/component/simple_button.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/04.research/research/provider/scrap_provider.dart';
import 'package:intermission_project/04.research/research/repository/research_repository.dart';
import 'package:intermission_project/04.research/research/repository/scrap_repository.dart';
import 'package:intermission_project/04.research/research/component/comment_part.dart';
import 'package:intermission_project/04.research/research/component/date_display_box.dart';
import 'package:intermission_project/04.research/research/view/google_form_web_view.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import '../component/render_loading.dart';

class ResearchDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'researchDetail';
  final String id;
  const ResearchDetailScreen({
    required this.id,
    super.key,
  });
  @override
  ConsumerState<ResearchDetailScreen> createState() =>
      _ResearchDetailScreenState();
}

class _ResearchDetailScreenState extends ConsumerState<ResearchDetailScreen> {
  TextEditingController commentController = TextEditingController();

  int daysLeft = 0;

  bool isButtonEnabled = true;

  bool isScrapped = false;

  bool isScraping = false; // 네트워크 요청 중인지 나타내는 변수

  Future<void> _handleScrap(ResearchDetailModel state) async {
    setState(() {
      isScrapped = !isScrapped; // 상태 반전
      isScraping = true; // 네트워크 요청 시작
    });

    var response =
        await ref.watch(scrapProvider.notifier).scrapResearch(id: widget.id);

    setState(() {
      isScraping = false; // 네트워크 요청 종료
    });

    if (response is ScrapResponse && response.isJoin == 'Y') {
      setState(() {
        print('스크랩 완료');
        isScrapped = true;
        ref.read(researchProvider.notifier).getDetail(id: widget.id);
        ref.read(scrapProvider.notifier).paginate(forceRefetch: true);
      });
    }
  }

  @override
  void initState() {
    ref.read(researchProvider.notifier).getDetail(id: widget.id);
    super.initState();
  }

  Future<void> _handleParticipation() async {
    var response = await ref
        .read(researchProvider.notifier)
        .participateInSurvey(id: widget.id);

    if (response is SurveyParticipationResponse && response.code == 200) {
      setState(() {
        ref.read(joinProvider.notifier).paginate();
        isButtonEnabled = false;

        print('비활');
      });
    }
  }

  // Future<void> _handleInterviewTesterParticipationResponse() async {
  //   var response = await ref
  //       .read(researchProvider.notifier)
  //       .participateInInterviewTester(id: widget.id);
  //
  //   if (response is SurveyParticipationResponse && response.code == 200) {
  //     setState(() {
  //       ref.read(joinProvider.notifier).paginate();
  //       isButtonEnabled = false;
  //       print('비활');
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(researchDetailProvider(widget.id));


    // 데이터가 없거나 로딩 중인 경우
    if (state is! ResearchDetailModel) {
      print('걸린다');
      print(state.toString());
      return Scaffold(body: renderLoading());
    } else {
      isScrapped = state.isScrap == "Y" ? true : false;

      if (state.participationStatus != "참여가능") {
        isButtonEnabled = false;
      }

      int _getDaysLeft() {
        DateTime now = DateTime.now();
        DateTime interviewDate = DateTime.parse(state.dueDate);
        Duration difference = interviewDate.difference(now);
        return difference.inDays + 1;
      }

      daysLeft = _getDaysLeft();

      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // 왼쪽으로 스와이프
            context.pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,

          /// AppBar
          appBar: AppBar(
            foregroundColor: Colors.black,
            title: Text(
              '${state.researchType} 상세 페이지',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () => context.go('/'),
            ),
            actions: [
              // IconButton(
              //   icon: Icon(
              //     Icons.share,
              //     color: Colors.black,
              //   ),
              //   onPressed: () {
              //     /// 공유 기능 구현 부분
              //   },
              // ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'report':
                      // 신고하기 로직
                      break;
                    case 'hide':
                      // 리서치 차단 로직
                      try {
                        await ref.read(userMeProvider.notifier).postBlock(state
                            .userId); // writerId는 실제 사용자 ID를 나타내는 필드여야 합니다. 이 부분을 정확한 필드명으로 수정해야 합니다.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('해당 리서치가 차단되었습니다.')));
                        ref
                            .read(researchProvider.notifier)
                            .getDetail(id: widget.id);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('리서치 차단 중 오류가 발생했습니다.')));
                      }
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'report',
                    child: Text('신고하기'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'hide',
                    child: Text('이 사용자의 글 보지 않기'),
                  ),
                ],
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          /// Body
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      researchBuildHeader(state, daysLeft),
                      researchBuildMainContent(state),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200], thickness: 8.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: researchBuildDescription(state),
                ),
                Divider(color: Colors.grey[200], thickness: 8.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child:
                      CommentComponent(state: state, ref: ref, id: widget.id),
                ),
              ],
            ),
          ),

          /// BottomNavigationBar
          bottomNavigationBar: _buildBottomButtons(state),
        ),
      );
    }
  }

  /// 스크랩 ~ 참여 버튼
  Widget _buildBottomButtons(ResearchDetailModel state) {
    bool isParticipationComplete = state.isOnGoing == "N";
    bool isEligibleForParticipation = state.isScreening == "N";
    bool isParticipationPossible = state.participationStatus == "참여완료";
    // 버튼 텍스트 설정
    String buttonText = '참여가능';
    if (isParticipationComplete) {
      buttonText = '참여자 모집이 완료되었습니다!';
      isButtonEnabled = false;
    } else if (isEligibleForParticipation) {
      buttonText = '참여 대상이 아닙니다!';
      isButtonEnabled = false;
    } else if (isParticipationPossible) {
      buttonText = '참여완료';
      isButtonEnabled = false;
    } else{
      buttonText = '참여가능'; //🥰
      isButtonEnabled = true;
    }

    return Container(
      height: 120,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, -1), // changes position of shadow
          ),
        ],
      ),
      child: BottomAppBar(
        child: Row(
          children: [
            Column(
              children: [
                IconButton(
                  icon: Transform.scale(
                    scale: 1.5,
                    child: Icon(
                      isScrapped ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.grey[400],
                    ),
                  ),
                  iconSize: 30,
                  onPressed: () {
                    setState(() {
                      _handleScrap(state);
                    });
                  },
                ),
                Flexible(
                  child: SizedBox(
                    height: 20,
                    child: Text(
                      isScraping ? "스크랩 중..." : state.scrapCnt.toString(),
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SimpleButton(
                isButtonEnabled: isButtonEnabled && state.isScreening != "N",
                onPressed: isButtonEnabled && state.isScreening != "N"
                    ? () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoogleFormWebView(
                              onComplete: () async {
                                var response = await ref
                                    .read(researchProvider.notifier)
                                    .participateInSurvey(id: widget.id);

                                if (response is SurveyParticipationResponse && response.code == 200) {
                                  setState(() {
                                    ref.read(joinProvider.notifier).paginate();
                                    isButtonEnabled = false;
                                    buttonText = "참여완료";

                                    print('비활성공');

                                    ref.read(researchProvider.notifier).getDetail(id: widget.id);
                                    ref.read(pointProvider);
                                    ref.read(userMeProvider.notifier).getMe();
                                  });
                                }
                              },
                              // homeUrl: state.researchUrl!,
                              homeUrl: state.researchUrl.toString(),
                            ),
                          ),
                        );
                      }
                    : null, // 비활성화 상태일 때 null
                buttonName: buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
