import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/const/colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  bool isNameValid = false;
  String? nameErrorText;

  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  void checkNameEnabled() {
    String name = nameController.text;
    bool isValid = RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(name);

    setState(() {
      isNameValid = isValid;
      nameErrorText = isValid ? null : '영문자 또는 한글로만 입력해 주세요';
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    nameController.addListener(() {
      checkNameEnabled();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: SizedBox(
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(50),
                    child: Text(
                      '회원가입',
                      style: customHeaderStyle,
                    ),
                  ),
                ),
                SizedBox(
                    width: 50,
                    height: 22,
                    child: Text(
                      '이름',
                      style: customTextStyle,
                    )),
                CustomTextFormField(
                  controller: nameController,
                  hintText: '이름을 입력해 주세요',
                  onChanged: (String value) {},
                  errorText: nameErrorText,
                ),
              ],
            ),
          ),
        ));
  }
}
