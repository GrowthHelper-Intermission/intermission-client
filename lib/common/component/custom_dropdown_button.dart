// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class CustomDropdown extends StatelessWidget {
//   final List<String> residenceType;
//   final String? selectedResidenceType;
//   final double dropdownWidth;
//   final double dropdownHeight;
//   final Function(String?) onChanged;
//   final Function() removeOverlay;
//
//   const CustomDropdown({
//     required this.residenceType,
//     required this.selectedResidenceType,
//     required this.dropdownWidth,
//     required this.dropdownHeight,
//     required this.onChanged,
//     required this.removeOverlay,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final LayerLink _layerLink = LayerLink();
//
//     return Stack(
//       children: [
//         Positioned(
//           width: dropdownWidth,
//           child: CompositedTransformFollower(
//             link: _layerLink,
//             offset: Offset(0, dropdownHeight),
//             child: Material(
//               color: Colors.white,
//               child: Container(
//                 height: (22.0 * residenceType.length) +
//                     (21 * (residenceType.length - 1)) +
//                     20,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: ListView.separated(
//                   physics: const ClampingScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   itemCount: residenceType.length,
//                   itemBuilder: (context, index) {
//                     return CupertinoButton(
//                       padding: const EdgeInsets.symmetric(horizontal: 14),
//                       pressedOpacity: 1,
//                       minSize: 0,
//                       onPressed: () {
//                         onChanged(residenceType.elementAt(index));
//                         removeOverlay();
//                       },
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           residenceType.elementAt(index),
//                           style: const TextStyle(
//                             fontSize: 16,
//                             height: 22 / 16,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8),
//                       child: Divider(
//                         color: Colors.grey,
//                         height: 20,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
