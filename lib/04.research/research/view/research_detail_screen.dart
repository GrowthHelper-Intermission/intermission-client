import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
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

    // `state`가 ResearchDetailModel인 경우
    daysLeft = _getDaysLeft(state.dueDate);

    isScrapped = state.isScrap == "Y" ? true : false;

    if (state.isJoin == "Y") {
      isButtonEnabled = false;
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
          onPressed: () => context.go('/'), // 현재의 라우트를 1 단계 되돌립니다.
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(state),
              _buildMainContent(state),
              Divider(color: Colors.grey[200], thickness: 8.0),
              _buildDescription(state),
              Divider(color: Colors.grey[200], thickness: 8.0),
              _buildComment(state),
              // _buildComment(state),
            ],
          ),
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
    int? replyingCommentId;

    int getTotalCommentCount(ResearchDetailModel model) {
      int commentCount = model.comments.length;
      int reCommentCount = model.comments
          .map(
            (comment) => comment.reComments?.length ?? 0,
      )
          .fold(0, (a, b) => a + b);  // reduce 대신 fold를 사용하여 초기값을 지정

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
              Text("${getTotalCommentCount(state)}개",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                await notifier.postComment(
                    widget.id, SingleComment(content: commentController.text));
                commentController.clear();
                ref.read(researchProvider.notifier).getDetail(id: widget.id);
                setState(() {});
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12),
              hintText: "댓글을 입력해 주세요",
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
                        if (value == 'edit') {
                          setState(() {
                            editingCommentId = comment.commentId;
                            commentController.text = comment.content;
                          });
                        } else if (value == 'delete') {
                          notifier.deleteComment(comment.commentId.toString());
                          setState(() {});
                          ref
                              .read(researchProvider.notifier)
                              .getDetail(id: widget.id);
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('수정하기'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('삭제하기'),
                        ),
                      ],
                      icon: Icon(Icons.more_vert,
                          color: Colors.grey[500], size: 20.0),
                    ),
                  ],
                ),
                if (editingCommentId == comment.commentId)
                  TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: "댓글 수정",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.save),
                        onPressed: () async {
                          if (commentController.text.isNotEmpty) {
                            notifier.updateComment(comment.commentId.toString(),
                                SingleComment(content: commentController.text));
                            commentController.clear();
                            editingCommentId = null;
                            setState(() {});
                            ref
                                .read(researchProvider.notifier)
                                .getDetail(id: widget.id);
                          }
                        },
                      ),
                    ),
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
                              bottom: MediaQuery.of(context)
                                  .viewInsets
                                  .bottom, // 키보드 높이만큼의 패딩 추가
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: "답글 내용을 입력하세요.",
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: reCommentController,
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
                                                      reCommentController.text),
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
                                          _timeAgo(DateTime.parse(
                                              reComment.createdDate)),
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
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    setState(() {
                                      editingCommentId =
                                          reComment.reCommentId; // 대댓글 ID로 변경
                                      commentController.text =
                                          reComment.content;
                                    });
                                  } else if (value == 'delete') {
                                    // 대댓글 삭제 로직
                                    // 현재 기능이 구현되어 있지 않으므로 코드를 추가해야 합니다.
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Text('수정하기'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('삭제하기'),
                                  ),
                                ],
                                icon: Icon(Icons.more_vert,
                                    color: Colors.grey[500],
                                    size: 20.0), // 아이콘 색상 및 크기 수정
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
                          await _handleParticipation();  // 콜백 내에서 참여 처리 함수 호출
                        },
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

  Widget _buildHeader(ResearchDetailModel state) {
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
          width: 38,
          height: 21,
          decoration: BoxDecoration(
            color: daysLeft <= 3 ? Colors.white : SUB_BLUE_COLOR,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: SUB_BLUE_COLOR,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              'D-$daysLeft',
              style: TextStyle(
                color: daysLeft <= 3 ? SUB_BLUE_COLOR : Colors.white,
                fontSize: 12.0,
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
        _buildInfoContainer(state),
        _buildParticipationInfo(state),
      ],
    );
  }

  Widget _buildInfoContainer(ResearchDetailModel state) {
    return Center(
      child: Container(
        width: 355,
        height: 110,
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
            _buildRowInfo('예상 소요시간', '${state.exceptTime}시간'),
            _buildRowInfo('마감일', state.dueDate),
            _buildRowInfo('최소 참여 요건', '${state.minAge}'),
          ],
        ),
      ),
    );
  }

  Widget _buildRowInfo(String title, String value) {
    const double titleWidth = 80.0; // 원하는 title의 넓이를 지정합니다.
    const double valueWidth = 200.0; // 원하는 value의 넓이를 지정합니다.

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 5),
      child: Row(
        children: [
          Container(
            width: titleWidth,
            child: Text(title, style: whiteSmallTextStyle),
          ),
          Expanded(
              child: SizedBox.shrink()), // to push the next text to the end
          Container(
            width: valueWidth,
            child: Text(value,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipationInfo(ResearchDetailModel state) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('설명'),
          Text(state.detail),
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
          3,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SkeletonParagraph(
              style: SkeletonParagraphStyle(
                lines: 3,
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
