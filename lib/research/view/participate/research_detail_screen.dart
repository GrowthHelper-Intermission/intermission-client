import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/common/component/show_custom_dialog.dart';
import 'package:intermission_project/point/provider/point_provider.dart';
import 'package:intermission_project/research/component/research_detail_components.dart';
import 'package:intermission_project/common/component/button/bottom_bar_next_button.dart';
import 'package:intermission_project/research/model/research_detail_model.dart';
import 'package:intermission_project/research/provider/research_provider.dart';
import 'package:intermission_project/research/provider/scrap_provider.dart';
import 'package:intermission_project/research/repository/research_repository.dart';
import 'package:intermission_project/research/view/participate/research_google_form_web_view.dart';
import 'package:intermission_project/user/provider/join_provider.dart';
import 'package:intermission_project/user/provider/user_me_provider.dart';
import '../../../common/component/render_loading.dart';

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
    // setState(() {
    //   isScraping = true; // 네트워크 요청 시작
    // });

    var response;
    if (isScrapped) {
      // 이미 스크랩되었으면 스크랩 취소 요청 확인
      showCustomDialog(
          context,
          '스크랩을 취소하시겠습니까?',
              () async { // onConfirm 콜백
            setState(() {
              isScraping = true; // 네트워크 요청 시작
            });

            var response = await ref
                .watch(scrapProvider.notifier)
                .scrapDeleteResearch(id: widget.id);

            if (response.code == 200 || response.code == 201) {
              print('스크랩 상태변환 완료');
              setState(() {
                isScrapped = !isScrapped; // 스크랩 상태 반전
                isScraping = false; // 네트워크 요청 종료
              });

              ref.read(researchProvider.notifier).getDetail(id: widget.id);
              ref.read(scrapProvider.notifier).paginate(forceRefetch: true);
            } else {
              setState(() {
                isScraping = false; // 네트워크 요청 종료
              });
              // 여기에 스크랩 실패 처리 로직을 추가할 수 있습니다.
            }
          }
      );
    }else {
      // 스크랩되지 않았으면 스크랩 신청 요청
      response =
          await ref.watch(scrapProvider.notifier).scrapResearch(id: widget.id);
    }

    if (response.code == 200) {
      isScraping = false;
      print('스크랩 상태변환 완료');
      setState(() {
        isScrapped = !isScrapped; // 스크랩 상태 반전
        print(isScrapped);
        print('now');
      });

      ref.read(researchProvider.notifier).getDetail(id: widget.id);
      ref.read(scrapProvider.notifier).paginate(forceRefetch: true);
    } else if (response.code == 201) {
      isScraping = false;
      print('스크랩 상태변환 완료');
      setState(() {
        isScrapped = !isScrapped; // 스크랩 상태 반전
        print(isScrapped);
        print('now@@');
      });

      ref.read(researchProvider.notifier).getDetail(id: widget.id);
      ref.read(scrapProvider.notifier).paginate(forceRefetch: true);
    } else {
      setState(() {
        isScraping = false; // 네트워크 요청 종료
      });
      // 여기에 스크랩 실패 처리 로직을 추가할 수 있습니다.
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

    if (response.code == 200) {
      setState(() {
        ref.read(joinProvider.notifier).paginate();
        isButtonEnabled = false;

        print('비활');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(researchDetailProvider(widget.id.toString()));
    print('State type: ${state.runtimeType}');
    // 데이터가 없거나 로딩 중인 경우
    if (state is! ResearchDetailModel) {
      print('걸린다');
      print(state.toString());
      return Scaffold(body: renderLoading());
    } else {
      isScrapped = state.isScrap == "Y" ? true : false;

      if (state.isEligible != "PARTICIPATION_POSSIBLE") {
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
              PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'report':
                      final resp = await ref
                          .read(researchProvider.notifier)
                          .reportResearchNow(
                              id: state.id.toString(), reportContent: '신고합니다.');
                      if (resp.code == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('해당 리서치가 신고되었습니다.'),
                          ),
                        );
                      }
                      break;
                    case 'hide':
                    // 리서치 차단 로직
                      try {
                        final response = await ref.read(researchProvider.notifier).researchBlock(widget.id);
                        if (response.code == 200 || response.code == 201) {
                          // 성공적으로 차단됨
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('해당 리서치는 차단되었습니다.'))
                          );
                          ref.read(researchProvider.notifier).paginate(forceRefetch: true);
                          // 차단 성공 후, 필요한 UI 업데이트나 페이지 이동 로직 추가
                          context.pop();
                        } else {
                          // 차단 실패
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('리서치 차단 중 오류가 발생했습니다.'))
                          );
                        }
                      } catch (e) {
                        // 예외 처리
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('리서치 차단 중 오류가 발생했습니다.'))
                        );
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
                    child: Text('해당 글 보지 않기'),
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
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //   child:
                //       CommentComponent(state: state, ref: ref, id: widget.id),
                // ),
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
    bool isParticipationComplete = state.isEligible == "PARTICIPATION_IMPOSSIBLE";
    bool isEligibleForParticipation = state.isEligible == "SCREENING_FAILED";
    bool isParticipationPossible = state.isEligible == "PARTICIPATION_COMPLETE";
    // 버튼 텍스트 설정
    String buttonText = '참여가능';
    if (isParticipationComplete) {
      buttonText = '참여자 모집이 완료되었습니다!';
      isButtonEnabled = false;
    } else if (isEligibleForParticipation) {
      buttonText = '참여 대상이 아닙니다!';
      isButtonEnabled = false;
    } else if (isParticipationPossible) {
      buttonText = '참여완료!';
      isButtonEnabled = false;
    } else {
      print('here');
      buttonText = '참여가능';
      setState(() {
        isButtonEnabled = true;
        print(isButtonEnabled);
      });
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
        surfaceTintColor: Colors.white,
        child: Row(
          children: [
            SizedBox(
              height: 65,
              child: Column(
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
                        isScraping ? "로딩 중..." : state.scrapCnt.toString(),
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BottomBarNextButton(
                isButtonEnabled: isButtonEnabled,
                onPressed: isButtonEnabled && state.isEligible == "PARTICIPATION_POSSIBLE"
                    ? () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResearchGoogleFormWebView(
                              onComplete: () async {
                                var response = await ref
                                    .read(researchProvider.notifier)
                                    .participateInSurvey(id: widget.id);

                                if (response is SurveyParticipationResponse &&
                                    response.code == 200) {
                                  setState(() {
                                    ref.read(joinProvider.notifier).paginate();
                                    isButtonEnabled = false;
                                    buttonText = "참여완료";

                                    print('비활성공');

                                    ref
                                        .read(researchProvider.notifier)
                                        .getDetail(id: widget.id);
                                    ref.read(pointProvider.notifier).paginate(forceRefetch: true);
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
