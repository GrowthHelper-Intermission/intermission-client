import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/model/single_comment.dart';
import 'package:intermission_project/04.research/research/provider/comment_provider.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intl/intl.dart';

import '../provider/research_provider.dart'; // 날짜와 시간 포매팅을 위한 패키지

class CommentComponent extends ConsumerStatefulWidget {
  final ResearchDetailModel state;
  final WidgetRef ref;
  final String id;  // widget.id 접근을 위해 추가

  CommentComponent({
    required this.state,
    required this.ref,
    required this.id,  // 생성자에 추가
  });

  @override
  _CommentComponentState createState() => _CommentComponentState();
}

class _CommentComponentState extends ConsumerState<CommentComponent> {
  final TextEditingController commentController = TextEditingController();
  final TextEditingController reCommentController = TextEditingController();

  int? editingCommentId;
  String hintText = "댓글달기";

  @override
  Widget build(BuildContext context) {
    return _buildComment(widget.state);
  }

  Widget _buildComment(ResearchDetailModel state) {
    final notifier = widget.ref.watch(commentNotifierProvider);

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
}



