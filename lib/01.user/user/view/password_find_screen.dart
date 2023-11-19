import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/layout/default_layout.dart';

class PasswordFindScreen extends StatefulWidget {
  const PasswordFindScreen({super.key});

  @override
  _PasswordFindScreenState createState() => _PasswordFindScreenState();
}

class _PasswordFindScreenState extends State<PasswordFindScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '비밀번호 찾기',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignupAskLabel(text: '이메일 입력'),
            CustomTextFormField(
              controller: emailController,
              onChanged: (String value) {},
              // other necessary properties like keyboardType
            ),
            SizedBox(height: 10),
            LoginNextButton(
              onPressed: () {
                getEmail(emailController.text);
              },
              buttonName: '인증번호 전송하기',
              isButtonEnabled: true, // or implement logic to enable/disable
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getEmail(String email) async {
    final dio = Dio();
    final response = await dio.post(
      'https://$ip/api/auth/email',
      data: {"email": "email"},
    );
    if (response.statusCode == 200) {
      // Show a success message using AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('성공'),
            content: Text('이메일 주소로 비밀번호가 전송되었습니다! 확인해보세요!'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to LoginScreen
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      // Handle errors or unsuccessful responses
    }
  }

}
