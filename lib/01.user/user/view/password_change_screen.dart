import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/home_screen.dart';

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
              onChanged: (String value) {
                _validatePasswords();
              },
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            SignupAskLabel(text: '새로운 비밀번호 확인'),
            CustomTextFormField(
              controller: checkPasswordController,
              onChanged: (String value) {
                _validatePasswords();
              },
              obscureText: true,
            ),
            SizedBox(height: 10,),
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
  void _validatePasswords() {
    if (newPasswordController.text == checkPasswordController.text) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  // 비밀번호 변경 로직
  void _changePassword() {
    final userNotifier = ref.read(userMeProvider.notifier);
    userNotifier.changePassword(
      currentPasswordController.text.trim(),
      newPasswordController.text.trim(),
    );
    context.pushReplacementNamed('/');
  }


}
