import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? name;
  final int? textFieldMinLine;
  final bool? enable;
  final int? maxLines; // 추가
  final bool? expands; // 추가

  const CustomTextFormField({
    this.enable,
    required this.onChanged,
    this.textFieldMinLine = 1,
    this.autofocus = false,
    this.obscureText = false,
    this.errorText,
    this.hintText,
    this.controller,
    this.name,
    this.maxLines, // 추가
    this.expands, // 추가
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
        onTap: () {
          setState(() {
            showErrorText = false;
          });
        },
        controller: widget.controller,
        cursorColor: CURSOR_COLOR,
        obscureText: widget.obscureText,
        obscuringCharacter: '●',
        minLines: widget.expands == true ? null : widget.textFieldMinLine, // 수정된 부분
        maxLines: widget.obscureText ? 1 : (widget.maxLines ?? 1),
        expands: widget.expands ?? false, // 연결
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
