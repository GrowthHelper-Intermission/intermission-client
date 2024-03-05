import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/component/custom_check_box.dart';
import '../../../../common/component/custom_text_form_field.dart';
import '../../../../common/component/button/next_button.dart';
import '../../../../common/component/common_ask_label.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/layout/default_layout.dart';
import '../../model/delete_user_model.dart';
import '../../model/user_model.dart';
import '../../provider/user_me_provider.dart';

class DeleteUserScreen2 extends ConsumerStatefulWidget {
  const DeleteUserScreen2({super.key});

  @override
  ConsumerState<DeleteUserScreen2> createState() => _DeleteUserScreen2State();
}

class _DeleteUserScreen2State extends ConsumerState<DeleteUserScreen2> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();

  bool isDifficult = false;
  bool isNoNeeded = false;
  bool isManyError = false;
  bool isCredit = false;
  bool isResearchSmall = false;
  bool isOtherReason = false;
  bool isButtonEnabled = false;

  TextEditingController otherReasonController = TextEditingController();
  bool isPasswordValid = false;
  bool isOtherReasonSelected = false;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userMeProvider); // 상태를 읽어옴
    UserModel? user; // UserModel을 nullable로 선언

    if (userState is UserModel) {
      user = userState; // UserModel로 캐스팅
    }

    void checkButtonEnabled() {
      setState(() {
        isButtonEnabled = isPasswordValid &&
            (isDifficult ||
                isNoNeeded ||
                isManyError ||
                isCredit ||
                isResearchSmall ||
                isOtherReason);
      });
    }

    void _validatePasswords() {
      final passwordRegex = RegExp(
          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
      isPasswordValid =
          passwordRegex.hasMatch(currentPasswordController.text.trim());

      // 비밀번호 유효성 검사 후 버튼 활성화 상태 업데이트
      checkButtonEnabled();
    }

    void updateCheckBox(bool newValue, String checkBox) {
      setState(() {
        isDifficult = checkBox == 'isDifficult' ? newValue : false;
        isNoNeeded = checkBox == 'isNoNeeded' ? newValue : false;
        isManyError = checkBox == 'isManyError' ? newValue : false;
        isCredit = checkBox == 'isCredit' ? newValue : false;
        isResearchSmall = checkBox == 'isResearchSmall' ? newValue : false;
        isOtherReason = checkBox == 'isOtherReason' ? newValue : false;
        checkButtonEnabled();
      });
    }

    void deleteUser() async {
      String deleteDescription = '';
      if (isDifficult) {
        deleteDescription = '앱이 이용하기 어려워요';
      } else if (isNoNeeded) {
        deleteDescription = '앱을 더이상 사용하지 않아요';
      } else if (isManyError) {
        deleteDescription = '앱에 오류가 많아요';
      } else if (isCredit) {
        deleteDescription = '포인트 구조가 마음에 들지 않아요';
      } else if (isResearchSmall) {
        deleteDescription = '참여할 리서치 수가 너무 작아요';
      } else if (isOtherReason) {
        deleteDescription = otherReasonController.text.trim();
      }

      final resp = await ref.watch(userMeProvider.notifier).deleteUser(
        DeleteUserModel(
          deleteDescription: deleteDescription,
          password: currentPasswordController.text.trim(),
        ),
      );


      if (resp.code == 200) {
        // Success dialog
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text("알림"),
            content: Text(
              "회원탈퇴가 완료되었습니다.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              TextButton(
                  child: Text("확인"),
                  onPressed: () {
                    ref.read(userMeProvider.notifier).logout();
                  }),
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

    return GestureDetector(
      onTap: () {
        // 현재 포커스를 해제하여 키보드를 숨김
        FocusScope.of(context).unfocus();
      },
      child: DefaultLayout(
        title: '회원 탈퇴',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonAskLabel(text: '비밀번호를 입력해 주세요!'),
                CustomTextFormField(
                  controller: currentPasswordController,
                  onChanged: (String value) {
                    _validatePasswords();
                  },
                  obscureText: true,
                ),
                CommonAskLabel(text: '탈퇴 사유를 선택해 주세요!'),
                CustomCheckBox(
                  isAgree: isDifficult,
                  title: '앱이 이용하기 어려워요',
                  onChanged: (value) {
                    updateCheckBox(value!, 'isDifficult');
                  },
                  color: RED_COLOR,
                ),
                CustomCheckBox(
                  isAgree: isNoNeeded,
                  title: '앱을 더이상 사용하지 않아요',
                  onChanged: (value) {
                    updateCheckBox(value!, 'isNoNeeded');
                  },
                  color: RED_COLOR,
                ),
                CustomCheckBox(
                  isAgree: isManyError,
                  title: '앱에 오류가 많아요',
                  onChanged: (value) {
                    setState(() {
                      updateCheckBox(value!, 'isManyError');
                    });
                  },
                  color: RED_COLOR,
                ),
                CustomCheckBox(
                  isAgree: isCredit,
                  title: '포인트 구조가 마음에 들지 않아요',
                  onChanged: (value) {
                    setState(() {
                      updateCheckBox(value!, 'isCredit');
                    });
                  },
                  color: RED_COLOR,
                ),
                CustomCheckBox(
                  isAgree: isResearchSmall,
                  title: '참여할 리서치 수가 너무 작아요',
                  onChanged: (value) {
                    setState(() {
                      updateCheckBox(value!, 'isResearchSmall');
                    });
                  },
                  color: RED_COLOR,
                ),
                CustomCheckBox(
                  isAgree: isOtherReason,
                  title: '기타',
                  onChanged: (value) {
                    setState(() {
                      isOtherReason = value!;
                      isOtherReasonSelected = isOtherReason;
                      updateCheckBox(value!, 'isOtherReason');
                    });
                  },
                  color: RED_COLOR,
                ),
                if (isOtherReasonSelected)
                  CustomTextFormField(
                    controller: otherReasonController,
                    onChanged: (String value) {},
                    hintText: '탈퇴 사유를 적어주세요',
                  ),
                SizedBox(
                  height: 20,
                ),
                NextButton(
                  onPressed: isButtonEnabled ? deleteUser : () {}, // 변경된 부분
                  buttonName: '탈퇴하기',
                  isButtonEnabled: isButtonEnabled,
                  color: RED_COLOR,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
