import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/component/signup_either_button.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/views/signup/signup_screen_page2.dart';

class SignupScreenPage2 extends StatefulWidget {
  const SignupScreenPage2({super.key});

  @override
  State<SignupScreenPage2> createState() => _SignupScreenPage2State();
}

class _SignupScreenPage2State extends State<SignupScreenPage2> {
  bool marriedSelected = false;
  bool unMarriedSelected = false;

  bool raisePet = false;
  bool raiseNoPet = false;

  String? residenceErrorText;

  final residenceType = ['선택', '1인 가구', '2인 가구', '3인 가구', '4인 가구', '5인 가구', '6인 가구',];
  String? selectedResidenceType;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedResidenceType = residenceType[0];
    });
  }


  // 드롭박스.
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  static const double _dropdownWidth = 360;
  static const double _dropdownHeight = 48;

  // CustomDropdown method
  OverlayEntry _customDropdown() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: _dropdownWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, _dropdownHeight),
          child: Material(
            color: Colors.white,
            child: Container(
              height: (22.0 * residenceType.length) +
                  (21 * (residenceType.length - 1)) +
                  20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: residenceType.length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    pressedOpacity: 1,
                    minSize: 0,
                    onPressed: () {
                      setState(() {
                        selectedResidenceType = residenceType.elementAt(index);
                      });
                      _removeOverlay();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        residenceType.elementAt(index),
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


  // 드롭다운 생성.
  void _createOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _customDropdown();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  // 드롭다운 해제.
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _overlayEntry?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: BORDER_COLOR,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(12),
                  right: ScreenUtil().setWidth(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SignupAppBar(currentPage: '2/3'),
              SignupAskLabel(text: '결혼 여부'),
              SizedBox(height: 8,),
              Row(
                children: [
                  SignupEitherButton(text: '미혼', isSelected: unMarriedSelected, onPressed: (){
                    setState(() {
                      unMarriedSelected = true;
                      marriedSelected = false;
                    });
                  }),
                  SizedBox(width: 10),
                  SignupEitherButton(text: '기혼', isSelected: marriedSelected, onPressed: (){
                    setState(() {
                      marriedSelected = true;
                      unMarriedSelected = false;
                    });
                  }),
                ],
              ),
              SizedBox(height: 20,),
              SignupAskLabel(text: '거주 형태'),
              SizedBox(height: 8,),
              // Center(
              //   child: Container(
              //     padding: EdgeInsets.only(left: 16,right: 16),
              //     decoration: BoxDecoration(
              //       border:Border.all(color: Colors.grey,width: 1),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     child: DropdownButton(
              //       value: selectedResidenceType,
              //       items: residenceType.map((type) =>
              //         DropdownMenuItem(value: type, child: Text(type)))
              //         .toList(),
              //       onChanged: (value) {
              //         setState(() {
              //           selectedResidenceType = value!;
              //         });
              //       },
              //       elevation: 0,
              //       icon: Icon(Icons.arrow_drop_down),
              //       iconSize: 24,
              //       isExpanded: true,
              //       hint: selectedResidenceType == '선택' ? Text('선택') : null,
              //       underline: SizedBox(),
              //       style: TextStyle(
              //             fontSize: 16,
              //             color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),
              Center(
                child: InkWell(
                  onTap: () {
                    _createOverlay();
                  },
                  child: CompositedTransformTarget(
                    link: _layerLink,
                    child: Container(
                      width: _dropdownWidth,
                      height: _dropdownHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 선택값.
                          Text(
                            selectedResidenceType.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              height: 22 / 16,
                              color: Colors.black,
                            ),
                          ),

                          // 아이콘.
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 36,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SignupAskLabel(text: '강아지를 키우시나요?'),
              SizedBox(height: 8,),
              Row(
                children: [
                  SignupEitherButton(text: '네', isSelected: raisePet, onPressed: (){
                    setState(() {
                      raisePet = true;
                      raiseNoPet = false;
                    });
                  }),
                  SizedBox(width: 10),
                  SignupEitherButton(text: '아니오', isSelected: marriedSelected, onPressed: (){
                    setState(() {
                      raiseNoPet = true;
                      raisePet = false;
                    });
                  }),
                ],
              ),
              SizedBox(height: 20,),
            ],
          ),
          ),
        )
        )
    );
  }
  // // 드롭다운.
  // OverlayEntry _customDropdown() {
  //   return OverlayEntry(
  //     maintainState: true,
  //     builder: (context) => Positioned(
  //       width: _dropdownWidth,
  //       child: CompositedTransformFollower(
  //         link: _layerLink,
  //         offset: const Offset(0, _dropdownHeight),
  //         child: Material(
  //           color: Colors.white,
  //           child: Container(
  //             height: (22.0 * residenceType.length) + (21 * (residenceType.length - 1)) + 20,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.grey),
  //               borderRadius: BorderRadius.circular(5),
  //             ),
  //             child: ListView.separated(
  //               physics: const ClampingScrollPhysics(),
  //               padding: const EdgeInsets.symmetric(vertical: 10),
  //               itemCount: residenceType.length,
  //               itemBuilder: (context, index) {
  //                 return CupertinoButton(
  //                   padding: const EdgeInsets.symmetric(horizontal: 14),
  //                   pressedOpacity: 1,
  //                   minSize: 0,
  //                   onPressed: () {
  //                     setState(() {
  //                       selectedResidenceType = residenceType.elementAt(index);
  //                     });
  //                     _removeOverlay();
  //                   },
  //                   child: Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       residenceType.elementAt(index),
  //                       style: const TextStyle(
  //                         fontSize: 16,
  //                         height: 22 / 16,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //               separatorBuilder: (context, index) {
  //                 return const Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 8),
  //                   child: Divider(
  //                     color: Colors.grey,
  //                     height: 20,
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
