import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/user/password/password_change_model.dart';
import 'package:intermission_project/user/user/model/user_model.dart';
import 'package:intermission_project/user/user/provider/user_me_provider.dart';

class PasswordChangeScreen extends ConsumerStatefulWidget {
  const PasswordChangeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PasswordChangeScreen> createState() =>
      _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends ConsumerState<PasswordChangeScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  bool isPasswordValid = true;

  bool isPasswordSameValid = false;

  void isValidPassword(String password) {
    final newPassword = newPasswordController.text.trim();
    bool isLengthValid = newPassword.length >= 8;
    bool hasLetter = RegExp(r'[A-Za-z]').hasMatch(newPassword);
    bool hasDigit = RegExp(r'\d').hasMatch(newPassword);
    bool hasSpecialCharacter = RegExp(r'[^A-Za-z0-9]').hasMatch(newPassword);

    setState(() {
      isPasswordValid = isLengthValid && hasLetter && hasDigit && hasSpecialCharacter;
    });

    validateButton();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userMeProvider); // 상태를 읽어옴
    UserModel? user; // UserModel을 nullable로 선언

    if (userState is UserModel) {
      user = userState; // UserModel로 캐스팅
    }

    return DefaultLayout(
      title: '비밀번호 변경',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 깎기 위함
                ),
                height: 90,
                alignment: Alignment.center, // 텍스트를 컨테이너 중앙에 배치
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "현재 비밀번호를 정확히 입력해주세요!\n8자 이상의 영문/숫자/특수문자 조합입니다.\n",
                    textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    maxLines: 3,
                  ),
                ),
              ),
            ),
            SignupAskLabel(text: '현재 비밀번호'),
            CustomTextFormField(
              controller: currentPasswordController,
              onChanged: (String value) {},
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            SignupAskLabel(text: '새로운 비밀번호'),
            CustomTextFormField(
              controller: newPasswordController,
              hintText: '8자 이상의 영문/숫자/특수문자 조합',
              onChanged: isValidPassword,
              obscureText: true,
              errorText:
                  isPasswordValid == false ? '8자 이상의 영문/숫자/특수문자 조합' : null,
            ),
            SizedBox(
              height: 10,
            ),
            SignupAskLabel(text: '새로운 비밀번호 확인'),
            CustomTextFormField(
              controller: checkPasswordController,
              onChanged: _validatePasswords,
              obscureText: true,
              errorText:
                  isPasswordSameValid == false ? '새로운 비밀번호와 똑같이 입력해주세요!' : null,
            ),
            SizedBox(
              height: 10,
            ),
            LoginNextButton(
              onPressed: isButtonEnabled ? _changePassword : () {}, // 변경된 부분
              buttonName: '완료',
              isButtonEnabled: isButtonEnabled,
            ),
          ],
        ),
      ),
    );
  }

  // 비밀번호 검증 함수
  void _validatePasswords(String value) {
    setState(() {
      isPasswordSameValid = newPasswordController.text == checkPasswordController.text;
    });

    validateButton();
  }

  void validateButton() {
    setState(() {
      isButtonEnabled = isPasswordValid && isPasswordSameValid;
    });
  }


  // 비밀번호 변경 로직
  void _changePassword() async {
    final userNotifier = ref.read(userMeProvider.notifier);

    final resp = await userNotifier.changePassword(PasswordChangeModel(
      checkPassword: currentPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
    ));

    if (resp == 200) {
      // Success dialog
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("알림"),
          content: Text(
            "비밀번호가 변경되었습니다!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("확인"),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RootTab()),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("알림"),
          content: Text("현재 비밀번호를 정확히 입력해주세요!"),
          actions: <Widget>[
            TextButton(
              child: Text("확인"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
