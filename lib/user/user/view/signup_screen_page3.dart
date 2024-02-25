import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intermission_project/certification/certification_test.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';


class SignupScreenPage3 extends ConsumerStatefulWidget {
  static String get routeName => 'signup3';
  const SignupScreenPage3({super.key});

  @override
  ConsumerState<SignupScreenPage3> createState() => _SignupScreenPage3State();
}

class _SignupScreenPage3State extends ConsumerState<SignupScreenPage3> {
  final globalKey = GlobalKey<FormState>();

  String? selectedBankType; // Change to nullable type
  TextEditingController accountNumberController = TextEditingController();
  String? accountErrorText;

  bool isButtonEnabled = true;

  void checkAccountEnabled() {
    String accountNumber = accountNumberController.text.trim();
    bool isAccountValid = accountNumber.isNotEmpty;
    setState(() {
      accountErrorText = isAccountValid ? null : '숫자만 입력해 주세요';
      // Call checkButtonEnabled here to update the button state
      checkButtonEnabled();
    });
  }

  void checkButtonEnabled() {
    // bool isMarriedSelected = marriedSelected || unMarriedSelected; //결혼 여부
    // bool isRaisingPetSelected = (raisePet && selectedPetType != petType[0]) ||
    //     raiseNoPet; //반려동물을 키우는지, 키운다면 어떤 종류인지 기입했는가까지,
    // // bool isRaisingPetSelected = selectedPetType != petType[0];
    //
    // bool isResidenceTypeSelected =
    //     selectedResidenceType != residenceType[0]; //거주 형태
    // bool isJobSelected = selectedJobCdType != jobCdType[0];
    // bool isSelectedCity = selectedCity != null;
    // bool isSelectedCountry = selectedCountry != null;
    //
    // bool isFieldsValid = isMarriedSelected &&
    //     isRaisingPetSelected &&
    //     isResidenceTypeSelected &&
    //     isJobSelected;
    // setState(() {
    //   isButtonEnabled = isFieldsValid && isSelectedCity && isSelectedCountry;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(12),
                  right: ScreenUtil().setWidth(12)),
              child: Form(
                key: globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SignupAppBar(currentPage: '3/3'),
                    // SignupAskLabel(text: '사용 은행'),
                    // Center(
                    //   child: GestureDetector(
                    //     ///
                    //     child: CustomDropdownButton(
                    //       dropdownWidth: 350,
                    //       items: bankAccountType,
                    //       hintText:  '선택',
                    //       onItemSelected: (value) {
                    //         selectedBankType = value;
                    //         checkButtonEnabled();
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    // SignupAskLabel(text: '계좌번호'),
                    // CustomTextFormField(
                    //   onlyNumber: true,
                    //   controller: accountNumberController,
                    //   onChanged: (String value) {
                    //     checkAccountEnabled();
                    //   },
                    //   hintText: '숫자만 입력',
                    //   showClearIcon: true,
                    // ),
                    // SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: LoginNextButton(
                        buttonName: '본인인증 실행하기',
                        isButtonEnabled: isButtonEnabled,
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CertificationTest(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
