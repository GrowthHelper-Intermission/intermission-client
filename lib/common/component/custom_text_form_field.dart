import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller; // 추가된 controller 파라미터
  final String? name;
  final int? textFieldMinLine;
  final bool? enable;

  const CustomTextFormField({
    this.enable,
    required this.onChanged,
    this.textFieldMinLine = 1 ,
    this.autofocus = false,
    this.obscureText = false,
    this.errorText,
    this.hintText,
    this.controller, // controller 파라미터 추가
    this.name,
    super.key,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showErrorText = false;
  @override
  Widget build(BuildContext context) {

    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: BORDER_COLOR,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 14, 6),
      child: TextFormField(
        enabled: widget.enable ?? true,
        // 텍스트 필드를 선택할 때마다 에러 텍스트 상태 초기화
        onTap: () {
          setState(() {
            showErrorText = false;
          });
        },
        controller: widget.controller, // 추가된 controller를 TextField에 연결
        cursorColor: CURSOR_COLOR,
        obscureText: widget.obscureText,
        obscuringCharacter: '●',
        minLines: widget.textFieldMinLine,
        maxLines: widget.textFieldMinLine,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12),
          hintText: widget.hintText,
          errorText: widget.errorText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14.0,
            color: Colors.grey[600],
          ),
          border: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: PRIMARY_COLOR,
            ),
          ),
          enabledBorder: baseBorder,
        ),
      ),
    );
  }
}

