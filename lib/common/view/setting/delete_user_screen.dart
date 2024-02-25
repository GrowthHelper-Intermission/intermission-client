import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/component/custom_check_box.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/common/view/select_screen.dart';
import 'package:intermission_project/user/user/model/user_model.dart';
import 'package:intermission_project/user/user/provider/user_me_provider.dart';
import 'package:intermission_project/user/user/view/delete_user_screen2.dart';


class DeleteUserScreen extends ConsumerStatefulWidget {
  const DeleteUserScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DeleteUserScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends ConsumerState<DeleteUserScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();

  bool isAgree = false;
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userMeProvider); // 상태를 읽어옴
    UserModel? user; // UserModel을 nullable로 선언

    if (userState is UserModel) {
      user = userState; // UserModel로 캐스팅
    }

    void checkButtonEnabled() {
      setState(() {
        isButtonEnabled = isAgree;
      });
    }

    return DefaultLayout(
      title: '회원 탈퇴',
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
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 120,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${user?.userName}님! ',
                              style: TextStyle(color: PRIMARY_COLOR)),
                          TextSpan(text: '정말로 탈퇴하시겠습니까?\n'),
                        ],
                      ),
                    ),
                    Text(
                      '회원탈퇴를 신청하기전, 유의사항을 꼭 읽어주세요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    // Include your other existing text here...
                  ],
                ),
              ),
            ),
            Container(
              width: 400, // Adjust the width as per your requirement
              height: 28,
              decoration: BoxDecoration(
                color: RED_COLOR, // Red background color

                border: Border.all(
                  color: Colors.red,
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Text(
                  '유의사항',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey[100], // Background color for the entire box
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 16)),
                      Expanded(
                        child: Text(
                          '회원탈퇴 후에 개인 정보, 포인트 적립 내역, 리서치 참여 이력 등의 데이터가 삭제되며 복구할 수 없습니다.',
                          style: TextStyle(
                            color: TEXT_GREY_COLOR,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5), // Space between items
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      Expanded(
                        child: Text(
                          '탈퇴 후 약 100일 동안은 동일한 개인정보로 재가입할 수 없습니다.',
                          style: TextStyle(
                            color: TEXT_GREY_COLOR,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5), // Space between items
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      Expanded(
                        child: Text(
                          '가입과 탈퇴가 반복된다면, 서비스 악용 사례로 판단하여 재가입이 불가능합니다.',
                          style: TextStyle(
                            color: TEXT_GREY_COLOR,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomCheckBox(
              isAgree: isAgree,
              title: '위 유의사항을 확인하였으며, 동의합니다.',
              onChanged: (value) {
                setState(() {
                  isAgree = value!;
                  checkButtonEnabled();
                });
              },
              color: RED_COLOR,
            ),
            SizedBox(
              height: 20,
            ),
            LoginNextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DeleteUserScreen2(),
                  ),
                );
              }, // 변경된 부분
              buttonName: '다음',
              isButtonEnabled: isButtonEnabled,
              color: RED_COLOR,
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

  // // 비밀번호 변경 로직
  // void deleteUser() {
  //   final userNotifier = ref.read(userMeProvider.notifier);
  //   userNotifier.deleteUser(new DeleteUserModel(
  //     deleteDescription: "인터미션 사랑해",
  //     password: "8829705x@",
  //   ));
  //   userNotifier.logout();
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => SelectScreen()), // Navigate to LoginScreen
  //   );
  // }
}

class SignupAskLabel2 extends StatelessWidget {
  final String text;
  const SignupAskLabel2({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 30,
      child: Text(
        text,
        style: customTextRedStyle,
        maxLines: 2,
      ),
    );
  }
}

class SignupAskLabel3 extends StatelessWidget {
  final String text;
  const SignupAskLabel3({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 30,
      child: Text(
        text,
        style: customTextGreenTwentyStyle,
        maxLines: 2,
      ),
    );
  }
}
