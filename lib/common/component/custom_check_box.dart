import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isAgree;
  final ValueChanged<bool?> onChanged;
  final String title;
  final bool? isArrow;
  final Color? color;

  const CustomCheckBox({
    Key? key, // Best practice: always add a Key parameter to stateless widgets
    this.color,
    required this.isAgree,
    required this.onChanged,
    required this.title,
    this.isArrow = false, // Default value is false if not provided
  }) : super(key: key); // Pass key to the super constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              value: isAgree,
              activeColor: color ?? Colors.green,
              checkColor: Colors.white,
              onChanged: onChanged,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Spacer(),
          if (isArrow ?? false) // isArrow가 null이 아니고 true일 경우에만 IconButton을 표시
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 20),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NewScreen()),
                // );
              },
            ),
          // 조건이 거짓이라면 아무것도 표시하지 않음
        ],
      ),
    );
  }
}