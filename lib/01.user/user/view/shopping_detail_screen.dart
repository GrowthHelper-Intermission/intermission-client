import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermission_project/01.user/user/model/point_change_model.dart';
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
import 'package:intermission_project/common/component/login_next_button.dart';
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
    formattedDate = DateFormat('yyyy-MM-dd')
        .format(threeDaysFromNow); // Initialize it here within initState
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pointProvider);

    // // 데이터가 없거나 로딩 중인 경우
    // if (state is CursorPaginationLoading || state == null) {
    //   return Scaffold(body: renderLoading());
    // }

    int totalPoints = 0; // Default value
    if (state is CursorPagination<PointModel>) {
      totalPoints = state.meta.pointAmount!; // Meta에서 totalPoint 가져오기
    }
    int point = widget.point;

    return DefaultLayout(
      isResize: true,
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

            onPressed: () async{
              PointChangeModel pointChangeModel = PointChangeModel(
                point: point,
              );
              try {
                // changePoint 요청을 보내고 응답을 받습니다.
                var response =  await ref
                    .read(pointProvider.notifier)
                    .repository
                    .changePoint(pointChangeModel: pointChangeModel);

                // 성공 응답 처리
                if (response.code == 200) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: PRIMARY_COLOR,
                        title: Text("성공"),
                        content: Text("포인트 교환이 완료되었습니다. 관리자에 의해 3일 이내에 송금됩니다!",style: TextStyle(color: Colors.white),),
                        actions: <Widget>[
                          // 확인 버튼 등
                        ],
                      );
                    },
                  );
                }
              } catch (e) {
                // 실패 응답 처리
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("실패"),
                      content: Text("포인트가 부족합니다ㅠㅠ"),
                      actions: <Widget>[
                        // 확인 버튼 등
                      ],
                    );
                  },
                );
              }

              ref.read(userMeProvider.notifier).getMe();
              ref.read(pointProvider.notifier).paginate(forceRefetch: true);
            },
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
                  'assets/img/shopping/ab.png',
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
                    '${widget.point}P를 ${widget.point}원으로 교환받을래요!',
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
                  Divider(
                    height: 1,
                    color: Colors.grey[200],
                  ),
                  InkWell(
                    onTap: _showAddDialog,
                    child: Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '받으실 곳',
                            style: whiteMiddleTextStyle,
                          ),
                          SvgPicture.asset(
                            'assets/img/rightArrow.svg',
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //아래 상자부터 UI작업 시작
                  // Image.asset('assets/img/exchange.png'),
                  SvgPicture.asset(
                    'assets/img/shopping/exchange.svg',
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
        accountNumberValid = isAccountValid;
        accountErrorText = accountNumberValid ? null : '숫자만 입력해 주세요';
      });
      checkButtonEnabled();
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: 15,
            top: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: SvgPicture.asset(
                  'assets/img/shopping/bottomSheet.svg',
                  // width: 400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '계좌번호 등록/변경', // 중앙 제목
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(); // 닫기 아이콘 클릭 시 BottomSheet 닫힘
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '포인트 교환 시 사용되며, 본인 명의의 계좌만 등록할 수 있습\n니다. 입력하신 개인 정보는 안전하게 보관됩니다.',
                    style: greySmallTextStyle,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SignupAskLabel(text: '현재 등록된 계좌정보'),
              ),
              SignupAskLabel(text: '사용 은행'),
              Center(
                child: GestureDetector(
                  child: CustomDropdownButton(
                    dropdownWidth: 350,
                    items: bankAccountType,
                    hintText: '선택',
                    onItemSelected: (value) {
                      selectedBankType = value;
                    },
                  ),
                ),
              ),
              SizedBox(height: 15),
              SignupAskLabel(text: '계좌번호'),
              CustomTextFormField(
                onlyNumber: true,
                controller: accountNumberController,
                onChanged: (String value) {
                  checkAccountEnabled();
                },
                errorText: accountNumberValid ? null : accountErrorText,
                hintText: '숫자만 입력',
                showClearIcon: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: LoginNextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Bottom sheet 닫기
                      /// PATCH 계좌번호 등록/변경 요청
                    },
                    buttonName: '변경하기',
                    isButtonEnabled: isButtonEnabled),
              ),
            ],
          ),
        );
      },
    );
  }
}

TextStyle customCashStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 20.0,
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
