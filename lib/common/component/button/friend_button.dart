import 'package:flutter/material.dart';

class FriendButton extends StatelessWidget {
  final String text;
  final String imageAsset;
  final Color color;
  final VoidCallback onPressed; // 콜백 함수 추가

  const FriendButton({
    Key? key,
    required this.text,
    required this.imageAsset,
    required this.color,
    required this.onPressed, // 콜백 함수 초기화
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: 340,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: onPressed, // 여기에 콜백 함수 연결
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      imageAsset,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
