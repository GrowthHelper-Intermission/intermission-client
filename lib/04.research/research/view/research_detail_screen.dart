import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:intermission_project/04.research/research/model/research_report_model.dart';
import 'package:intermission_project/04.research/research/model/single_comment.dart';
import 'package:intermission_project/04.research/research/provider/comment_provider.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/04.research/research/provider/scrap_provider.dart';
import 'package:intermission_project/04.research/research/repository/research_repository.dart';
import 'package:intermission_project/04.research/research/repository/scrap_repository.dart';
import 'package:intermission_project/04.research/research/view/google_form_web_view.dart';
import 'package:intermission_project/04.research/research/view/simple_button.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'package:intl/intl.dart'; // 날짜와 시간 포매팅을 위한 패키지

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
  // final ScrollController controller = ScrollController();
  TextEditingController commentController = TextEditingController();

  int daysLeft = 0;

  bool isButtonEnabled = true;
  bool isScrapped = false;

  int _getDaysLeft(String dueDate) {
    DateTime now = DateTime.now();
    DateTime interviewDate = DateTime.parse(dueDate);
    Duration difference = interviewDate.difference(now);
    return difference.inDays + 1;
  }

  Future<void> _handleScrap(ResearchDetailModel state) async {
    var response =
        await ref.watch(scrapProvider.notifier).scrapResearch(id: widget.id);

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
    // TODO: implement initState
    super.initState();

    ref.read(researchProvider.notifier).getDetail(id: widget.id);
  }

  Future<void> _handleParticipation() async {
    var response = await ref
        .read(researchProvider.notifier)
        .participateInResearch(id: widget.id);

    if (response is ParticipationResponse && response.isJoin == 'Y') {
      setState(() {
        isButtonEnabled = false;
        print('비활');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(researchDetailProvider(widget.id));

    // 데이터가 없거나 로딩 중인 경우
    if (state == null || state is! ResearchDetailModel) {
      return Scaffold(body: renderLoading());
    }

    isScrapped = state.isScrap == "Y" ? true : false;

    if (state.isJoin == "Y") {
      isButtonEnabled = false;
    }

    int _getDaysLeft() {
      DateTime now = DateTime.now();
      DateTime interviewDate = DateTime.parse(state.dueDate);
      Duration difference = interviewDate.difference(now);
      return difference.inDays + 1;
    }

    daysLeft =
        _getDaysLeft(); // Every time the widget is built, update the days left.

    String displayText;
    Color borderColor;
    Color textColor;
    Color backgroundColor;

    FocusNode editCommentFocusNode = FocusNode();

    if (daysLeft > 3) {
      displayText = 'D-$daysLeft';
      borderColor = SUB_BLUE_COLOR;
      textColor = SUB_BLUE_COLOR;
      backgroundColor = Colors.white;
    } else if (daysLeft > 0) {
      displayText = 'D-$daysLeft';
      borderColor = SUB_BLUE_COLOR;
      textColor = SUB_BLUE_COLOR;
      backgroundColor = Colors.white;
    } else if (daysLeft == 0) {
      displayText = 'D-day';
      borderColor = SUB_BLUE_COLOR;
      textColor = Colors.white;
      backgroundColor = SUB_BLUE_COLOR;
    } else {
      displayText = '마감';
      borderColor = PRIMARY_COLOR;
      textColor = Colors.white;
      backgroundColor = PRIMARY_COLOR;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {
              // 공유 기능 구현 부분
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // 선택된 메뉴 아이템에 따른 로직 구현
              if (value == 'report') {
                try {
                  ref.read(researchProvider.notifier).reportResearchNow(id: widget.id.toString(), content: 'lets get it!');
                  print(widget.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('리서치 게시물이 신고되었습니다.')));
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('댓글 신고 중 오류가 발생했습니다.')));
                }
              }
              // 기타 메뉴 아이템에 대한 로직 추가 가능
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'report',
                child: Text('신고하기'),
              ),
              // 필요하다면 여기에 다른 메뉴 아이템 추가 가능
            ],
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
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
                  _buildHeader(state, displayText, textColor, borderColor,
                      backgroundColor),
                  _buildMainContent(state),
                ],
              ),
            ),
            Divider(color: Colors.grey[200], thickness: 8.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: _buildDescription(state),
            ),
            Divider(color: Colors.grey[200], thickness: 8.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: _buildComment(state),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(state),
    );
  }

  Widget _buildComment(ResearchDetailModel state) {
    final notifier = ref.watch(commentNotifierProvider);

    final TextEditingController reCommentController = TextEditingController();
    final TextEditingController editCommentController = TextEditingController();

    int? editingCommentId;

    String hintText = "댓글달기";

    int getTotalCommentCount(ResearchDetailModel model) {
      int commentCount = model.comments.length;
      int reCommentCount = model.comments
          .map(
            (comment) => comment.reComments?.length ?? 0,
          )
          .fold(0, (a, b) => a + b); // reduce 대신 fold를 사용하여 초기값을 지정
      return commentCount + reCommentCount;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Text("댓글",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Text(
                "${getTotalCommentCount(state)}개",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 14, 6),
          child: TextFormField(
            controller: commentController,
            cursorColor: Colors.black, // 예시 CURSOR_COLOR
            obscureText: false,
            onChanged: (text) {
              // 필요한 경우에 사용할 수 있는 부분
            },
            onFieldSubmitted: (text) async {
              if (commentController.text.isNotEmpty) {
                if (editingCommentId == null) {
                  // This is a new comment
                  await notifier.postComment(widget.id,
                      SingleComment(content: commentController.text));
                } else {
                  // This is an edit
                  await notifier.updateComment(editingCommentId.toString()!,
                      SingleComment(content: commentController.text));
                  editingCommentId = null; // Reset
                  hintText = "댓글달기"; // Reset
                }
                commentController.clear();
                ref.read(researchProvider.notifier).getDetail(id: widget.id);
                setState(() {});
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12),
              hintText: "댓글을 입력하세요",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
              border: OutlineInputBorder(), // 예시 baseBorder
              focusedBorder: OutlineInputBorder().copyWith(
                borderSide: BorderSide(
                  color: PRIMARY_COLOR, // 예시 PRIMARY_COLOR
                ),
              ),
              enabledBorder: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 16),
        Column(
          children: state.comments.map((comment) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/img/pinkCircle.png',
                        width: 40, height: 40), // Image asset 추가 (댓글)
                    SizedBox(width: 5), // 이미지와 텍스트 사이의 간격 조정
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${comment.writer}"),
                              SizedBox(width: 5),
                              Text(
                                "·",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                              SizedBox(width: 5),
                              Text(
                                _timeAgo(DateTime.parse(comment.createdDate)),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text("${comment.content}"),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete') {
                          notifier.deleteComment(comment.commentId.toString());
                          setState(() {
                            ref
                                .read(researchProvider.notifier)
                                .getDetail(id: widget.id);
                          });
                        } else if (value == 'report') {
                          try {
                            notifier
                                .reportComment(comment.commentId.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('댓글이 신고되었습니다.')));
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('댓글 신고 중 오류가 발생했습니다.')));
                          }
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        if (comment.isMyComment == 'Y') {
                          return <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('삭제하기'),
                            ),
                          ];
                        } else {
                          return <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'report',
                              child: Text('신고하기'),
                            ),
                          ];
                        }
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.grey[500],
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Text("답글 달기", style: TextStyle(color: Colors.grey)),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "답글 내용을 입력하세요.",
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: reCommentController,
                                    onChanged: (text) {
                                      // 필요한 경우에 사용할 수 있는 부분
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Spacer(),
                                      TextButton(
                                        child: Text("완료"),
                                        onPressed: () async {
                                          if (reCommentController
                                              .text.isNotEmpty) {
                                            await notifier.postReComment(
                                              widget.id,
                                              comment.commentId.toString(),
                                              SingleComment(
                                                content:
                                                    reCommentController.text,
                                              ),
                                            );
                                            reCommentController.clear();
                                            Navigator.of(context).pop();
                                            setState(() {});
                                            ref
                                                .read(researchProvider.notifier)
                                                .getDetail(id: widget.id);
                                          }
                                        },
                                      ),
                                      TextButton(
                                        child: Text("취소"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    children: comment.reComments.map((reComment) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/img/blueCircle.png',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${reComment.writer}"),
                                        SizedBox(width: 5),
                                        Text(
                                          "·",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          _timeAgo(
                                            DateTime.parse(
                                                reComment.createdDate),
                                          ),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1),
                                    Text("${reComment.content}"),
                                  ],
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) async {
                                  if (value == 'delete') {
                                    try {
                                      await ref
                                          .read(commentNotifierProvider)
                                          .deleteComment(
                                              reComment.reCommentId as String);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Comment deleted successfully')));
                                    } catch (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Error deleting comment')));
                                    }
                                  } else if (value == 'report') {
                                    try {
                                      await ref
                                          .read(commentNotifierProvider)
                                          .reportComment(
                                              reComment.reCommentId.toString());
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text('대댓글이 신고되었습니다.')));
                                    } catch (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  '대댓글 신고 중 오류가 발생했습니다.')));
                                    }
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  if (reComment.isMyComment == 'Y') {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'delete',
                                        child: Text('삭제하기'),
                                      ),
                                    ];
                                  } else {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'report',
                                        child: Text('신고하기'),
                                      ),
                                    ];
                                  }
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.grey[500],
                                  size: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomButtons(ResearchDetailModel state) {
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
                      _handleScrap(state); // 비동기 처리가 필요한 경우 await 키워드 추가
                      setState(() {}); // 상태 변경 후 위젯을 재빌드하기 위해 setState 호출
                    });
                  },
                ),
                Flexible(
                  child: SizedBox(
                    height: 20, // Text 위젯의 최대 높이를 제한
                    child: Text(state.scrapCnt.toString(),
                        style: TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SimpleButton(
                isButtonEnabled: isButtonEnabled,
                onPressed: isButtonEnabled
                    ? () async {
                        // await _handleParticipation();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoogleFormWebView(
                              onComplete: () async {
                                await _handleParticipation(); // 콜백 내에서 참여 처리 함수 호출
                              },
                              completionURL:
                                  'https://docs.google.com/forms/d/e/1FAIpQLSdMOssE_VzRdeKVid0UlNDAtuxYLuN6uMVy-_zJIreNr7ZBmA/formResponse?pli=1',
                              homeUrl:
                                  'https://docs.google.com/forms/d/1AkYT38aaIB9ACx1C60xcbzGJxF_BHTyRebaZt2_QPsQ/viewform?edit_requested=true&pli=1',
                            ),
                          ),
                        );
                      }
                    : null, // 비활성화 상태일 때 null
                buttonName: isButtonEnabled ? '참여하기' : '참여완료',
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays >= 3) {
      return DateFormat('MM/dd/yyyy').format(date); // 예: 08/27/2023
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}일 전';
    } else {
      return '오늘';
    }
  }

  Widget _buildHeader(ResearchDetailModel state, String displayText,
      Color textColor, Color borderColor, Color backgroundColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _mapResearchTypeToText(state.researchType),
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          width: 50,
          height: 21,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              displayText,
              style: TextStyle(
                color: textColor,
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(ResearchDetailModel state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(state.mainTitle, style: customTextStyle),
        SizedBox(height: 5),
        Text(state.subTitle, style: whiteSmallTextStyle),
        SizedBox(height: 5),
        Row(
          children: [
            Text(state.researchMethTpCd, style: whiteSmallTextStyle),
            Text(' | ', style: whiteSmallTextStyle),
            Text('${state.exceptTime}시간 ', style: whiteSmallTextStyle),
            Text(state.researchRewdAmt, style: whiteSmallTextStyle),
          ],
        ),
        SizedBox(height: 5),
        _buildInfoContainer(state),
        _buildParticipationInfo(state),
      ],
    );
  }

  Widget _buildInfoContainer(ResearchDetailModel state) {
    return Center(
      child: Container(
        width: 355,
        height: 130,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.grey.shade200,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRowInfo('소요시간', '${state.exceptTime}시간'),
            _buildRowInfo('마감일', state.dueDate),
            _buildRowInfo('대상', state.minAge),
            _buildRowInfo('모집 인원', state.researchEntryCnt),
          ],
        ),
      ),
    );
  }

  Widget _buildRowInfo(String title, String value) {
    const double titleWidth = 80.0;
    const double valueWidth = 220.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 5),
      child: Row(
        children: [
          Container(
            width: titleWidth,
            child: Text(title, style: whiteBlueTextStyle),
          ),
          Expanded(
              child: SizedBox.shrink()), // to push the next text to the end
          Container(
            width: valueWidth,
            child: Text(value, style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipationInfo(ResearchDetailModel state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.check,
                size: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '현재 ', style: whiteMiddleTextStyle),
                TextSpan(
                  text: '${state.researchCnt}',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                TextSpan(text: '명이 참여했어요!', style: whiteMiddleTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(ResearchDetailModel state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '설명',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            state.detail,
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _mapResearchTypeToText(String researchType) {
    switch (researchType) {
      case 'survey':
        return '설문조사';
      case 'interview':
        return '인터뷰';
      case 'test':
        return '테스트 참여';
      default:
        return researchType;
    }
  }

  // 로딩 위젯을 Sliver가 아닌 일반 Padding 위젯으로 변경
  Widget renderLoading() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Column(
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SkeletonParagraph(
              style: SkeletonParagraphStyle(
                lines: 4,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  final String buttonName;
  final bool isButtonEnabled;
  final VoidCallback? onPressed;

  const SimpleButton({
    required this.onPressed,
    required this.buttonName,
    required this.isButtonEnabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          primary: isButtonEnabled ? PRIMARY_COLOR : Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
