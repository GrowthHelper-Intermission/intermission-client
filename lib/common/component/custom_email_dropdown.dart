import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomEmailDropdown customDropdown = CustomEmailDropdown();

class CustomEmailDropdown {
  // 이메일 자동 입력창.
  OverlayEntry emailRecommendation({
    required double width,
    required EdgeInsets margin,
    required LayerLink layerLink,
    required TextEditingController controller,
    required Function(String) onPressed,
  }) {
    const List<String> _emailList = [
      '@gmail.com',
      '@naver.com',
      '@kakao.com',
      '@daum.net',
    ];
    final _emailListLength = _emailList.length;

    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: const Offset(-15, 48),
          child: Material(
            color: Colors.white,
            child: Container(
              height: (22.0 * _emailListLength) + (21 * (_emailListLength - 1)) + 20,
              margin: margin,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: _emailList.length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    pressedOpacity: 1,
                    minSize: 0,
                    onPressed: () {
                      // 완전한 이메일 주소 생성
                      String fullEmail = '${controller.text}${_emailList.elementAt(index)}';

                      // 이메일 주소를 TextField에 설정하고 콜백 호출
                      controller.text = fullEmail;
                      onPressed(fullEmail); // 수정된 부분: 이메일 주소를 인자로 전달
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${controller.text}${_emailList.elementAt(index)}',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 22 / 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}