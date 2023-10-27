// 로딩 위젯을 Sliver가 아닌 일반 Padding 위젯으로 변경
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

Widget renderLoading() {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 20.0,
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