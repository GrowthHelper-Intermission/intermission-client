import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/point_provider.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/01.user/user/repository/user_me_repository.dart';
import 'package:intermission_project/01.user/user/view/user_point_count_screen.dart';
import 'package:intermission_project/04.research/research/component/simple_button.dart';
import 'package:intermission_project/common/component/custom_dropdown_button.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/const/type_data.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intl/intl.dart';


class ShoppingDetailScreen extends ConsumerStatefulWidget {
  int point;
  ShoppingDetailScreen({
    required this.point,
    super.key,
  });

  @override
  ConsumerState<ShoppingDetailScreen> createState() =>
      _ShoppingDetailScreenState();
}

class _ShoppingDetailScreenState extends ConsumerState<ShoppingDetailScreen> {
  late String serverCode;
  late String message;
  late String formattedDate; // Declare the variable here without initializing

  @override
  void initState() {
    super.initState();
    DateTime threeDaysFromNow = DateTime.now().add(Duration(days: 3));
    formattedDate = DateFormat('yyyy-MM-dd').format(threeDaysFromNow); // Initialize it here within initState
  }


  void requestExchange() async {
    /// 유저 포인트 접근 필요
    final userState = ref.read(userMeProvider.notifier);
    // 유저 상태에서 토큰 가져오기, 이 부분은 상태 관리 구조에 따라 달라질 수 있습니다.
    final accessToken = userState;

    try {
      var dio = Dio();
      var data = {
        /// test 금액
        "point": 1000000,
      };

      var response = await dio.post(
        'https://$ip/api/point',
        data: data,
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJFbWFpbCI6InRlc3RAbmF2ZXIuY29tIiwiZXhwIjoxNjk5MzAyNzE0fQ.xwN8-hchYQyfUWrI8s2qiaPJYEIQPrjFjtR3PlVZVDXgitPNAD_-PfHrFRBctZNC8aYiWRxxC1cSOOyIemyFEg", // 여기에 Bearer 토큰을 추가
            // 다른 헤더들도 필요하다면 여기에 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        var message = response.data["message"];
        print(message);
        // 성공적으로 포인트 교환 요청 처리 후 추가 로직 구현
      } else {
        // 서버가 성공이 아닌 다른 상태 코드를 반환했을 때의 처리
      }
    } catch (e) {
      if (e is DioError) {
        // 에러 응답에 대한 처리
        print(e.response?.data);
      } else {
        // Dio 이외의 에러 처리
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pointProvider);

    // 데이터가 없거나 로딩 중인 경우
    if (state is CursorPaginationLoading || state == null) {
      return Scaffold(body: renderLoading());
    }

    int totalPoints = 0; // Default value
    if (state is CursorPagination<PointModel>) {
      totalPoints = state.meta.totalPoint!; // Meta에서 totalPoint 가져오기
    }
    return DefaultLayout(
      title: '',
      bottomNavigationBar: Container(
        height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, -1), // changes position of shadow
            ),
          ],
        ),
        child: BottomAppBar(
          child: SimpleButton(
            onPressed: requestExchange,
            isButtonEnabled: true,
            buttonName: '교환하기',
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                child: Image.asset(
                  'assets/img/ab.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '현금 교환',
                    style: blackSmallTextStyle,
                  ),
                  Text(
                    '${widget.point}P -> ${widget.point}원',
                    style: customCashStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '교환 예정일',
                          style: whiteMiddleTextStyle,
                        ),
                        Text(
                          formattedDate, // Use the formattedDate variable here
                          style: blackSmallTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Divider(
                      height: 1,
                      color: Colors.grey[200],
                    ),
                  ),
                  Container(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '받으실 곳',
                          style: whiteMiddleTextStyle,
                        ),
                        InkWell(
                          onTap: () {
                            _showAddDialog();
                          },
                          child: SvgPicture.asset(
                            'assets/img/rightArrow.svg',
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 5),
                    child: Divider(
                      height: 1,
                      color: Colors.grey[200],
                    ),
                  ),
                  //아래 상자부터 UI작업 시작
                  // Image.asset('assets/img/exchange.png'),
                  SvgPicture.asset(
                    'assets/img/exchange.svg',
                    width: 400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // '추가하기' 선택 시 표시될 대화상자
  void _showAddDialog() {
    late String selectedBankType;
    TextEditingController accountNumberController = TextEditingController();
    String? accountErrorText;
    bool accountNumberValid = false;

    bool isButtonEnabled = false;

    void checkButtonEnabled() {
      setState(() {
        isButtonEnabled = true;
      });
    }

    void checkAccountEnabled() {
      String accountNumber = accountNumberController.text.trim();
      bool isAccountValid = accountNumber.length >= 9;
      setState(() {
        //phoneNumErrorText = isValid ? null : '올바른 전화번호 형식이 아닙니다';
        accountNumberValid = isAccountValid;
        accountErrorText = accountNumberValid ? null : '숫자만 입력해 주세요';
      });
      checkButtonEnabled();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // 모서리를 둥글게
            side: BorderSide(
              color: PRIMARY_COLOR,
              width: 2,
            ), // 테두리 색과 두께
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: const Text('계좌 등록하기'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(
                color: Colors.grey[300],
                thickness: 2,
              ),
              SignupAskLabel(text: '사용 은행'),
              Center(
                child: CustomDropdownButton(
                  dropdownWidth: 250,
                  items: bankAccountType,
                  hintText: '선택',
                  onItemSelected: (value) {
                    setState(
                      () {
                        selectedBankType = value;
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SignupAskLabel(text: '계좌번호'),
              CustomTextFormField(
                controller: accountNumberController,
                onChanged: (String value) {
                  checkAccountEnabled();
                },
                errorText: accountNumberValid ? null : accountErrorText,
              ),
              buildElevatedButton('계좌 변호 변경하기', () {
                Navigator.of(context).pop(); // 대화상자 닫기
                /// PATCH 계좌번호 등록/변경 요청
              }),
            ],
          ),
        );
      },
    );
  }
}

TextStyle customCashStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 24.0,
  color: Colors.black,
);

Widget buildElevatedButton(String buttonName, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, // 글자 색상
        backgroundColor: Colors.white, // 배경 색상
        side: const BorderSide(
          color: PRIMARY_COLOR, // 여기에 실제 사용할 색상 코드를 입력하세요.
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 테두리 둥글기
        ),
        minimumSize: const Size(
          double.infinity, // 버튼 너비 최대로
          50, // 버튼 높이
        ),
      ),
      child: Text(
        buttonName,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 22,
          color: BLUE_COLOR,
        ),
      ),
    ),
  );
}
