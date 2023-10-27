// custom_date_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:ui';


class CustomDatePicker extends StatefulWidget {
  final String initialText;
  final String labelText;
  final TextEditingController controller;
  final ValueChanged<DateTime?> onDateSelected;

  CustomDatePicker({
    Key? key,
    required this.initialText,
    required this.labelText,
    required this.controller,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}


class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? tempPickedDate;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() { // 오타 수정
    super.initState();
    widget.controller.text = widget.initialText;
  }

  _selectDate() async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: ThemeData
          .light()
          .scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('취소'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    CupertinoButton(
                      child: Text('완료'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    backgroundColor: ThemeData
                        .light()
                        .scaffoldBackgroundColor,
                    minimumYear: 1900,
                    maximumYear: DateTime
                        .now()
                        .year,
                    initialDateTime: DateTime.now(),
                    maximumDate: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.controller.text = convertDateTimeDisplay(pickedDate.toString());
      });
      widget.onDateSelected(pickedDate); // 콜백 호출
    }
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    return serverFormater.format(displayDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _selectDate();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.labelText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
              isDense: true,
            ),
            controller: widget.controller,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}