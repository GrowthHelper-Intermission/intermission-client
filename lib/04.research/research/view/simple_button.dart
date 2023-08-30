// import 'package:flutter/material.dart';
// import 'package:intermission_project/common/const/colors.dart';
//
// class SimpleButton extends StatelessWidget {
//   final String buttonName;
//   final VoidCallback? onPressed;
//   final Color buttonColor;
//
//   const SimpleButton({
//     required this.buttonName,
//     this.onPressed,
//     this.buttonColor = PRIMARY_COLOR,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           primary: onPressed != null ? buttonColor : Colors.grey[200],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: Text(
//           buttonName,
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             fontSize: 16,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
