import 'package:flutter/material.dart';

class FriendButton extends StatelessWidget {
  final String text;
  final String imageAsset;
  final Color color;

  const FriendButton({
    Key? key,
    required this.text,
    required this.imageAsset,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
      child: Container(
        width: 340,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: () {
            // 버튼 눌림 로직 추가
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      height: 23,
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
