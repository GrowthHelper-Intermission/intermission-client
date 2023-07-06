import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

// class HomeBottomButtom extends StatelessWidget {
//   final VoidCallback onTap;
//
//   const HomeBottomButtom({required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 3),
//       child: Container(
//         width: 335,
//         height: 48,
//         decoration: BoxDecoration(
//           color: Colors.white, // Customize the button color here
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: SUB_BLUE_COLOR,
//             width: 1.0,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             '친구초대하고 300P받기',
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: SUB_BLUE_COLOR, // Customize the button text color here
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

class HomeBottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const HomeBottomButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Container(
          width: 335,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white, // Customize the button color here
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: SUB_BLUE_COLOR,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Text(
              '친구초대하고 300P받기',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: SUB_BLUE_COLOR, // Customize the button text color here
              ),
            ),
          ),
        ),
      ),
    );
  }
}
