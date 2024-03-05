import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intermission_project/common/component/button/friend_button.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/layout/default_layout.dart';
import 'package:intermission_project/research/model/friend_code_model.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_share.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

import '../../../common/component/custom_text_form_field.dart';
import '../../../common/component/button/next_button.dart';
import '../../../common/component/common_ask_label.dart';
import '../../../common/view/splash/splash_screen.dart';
import '../../user/model/user_model.dart';
import '../../../point/provider/point_provider.dart';
import '../../user/provider/user_me_provider.dart';

// PointProvider를 사용하여 추천인 코드를 저장하는 StateNotifierProvider를 정의합니다.
final referralCodeProvider = StateProvider<String?>((ref) => null);

final TextTemplate defaultText = TextTemplate(
  text: '회원 가입 후 추천인 코드를 입력 하면 두분 모두에게 300원의 추가 적립금을 드려요!',
  link: Link(
    webUrl: Uri.parse(
        'https://apps.apple.com/us/app/인터미션-intermission/id6471970116'),
    iosExecutionParams: {
      'url': 'https://apps.apple.com/us/app/인터미션-intermission/id6471970116'
    },
  ),
);

class FriendInviteScreen extends ConsumerStatefulWidget {
  FriendInviteScreen({super.key});

  @override
  ConsumerState<FriendInviteScreen> createState() => _FriendInviteScreenState();
}

class _FriendInviteScreenState extends ConsumerState<FriendInviteScreen> {
  TextEditingController friendCodeController = TextEditingController();
  bool isfriendCodeValid = false;
  void checkFriendCodeEnabled(String value) {
    String friendCode = friendCodeController.text.trim();
    setState(() {
      print('wk');
      isfriendCodeValid = friendCode.length >= 5; // 길이가 5자 이상인지 확인
      print(isfriendCodeValid);
    });
  }

  void showAddDialog() {
    final pointState = ref.watch(pointProvider);
    void checkFriendCodeEnabled(String value) {
      String friendCode = friendCodeController.text.trim();
      setState(() {
        print('wk');
        isfriendCodeValid = friendCode.length >= 5; // 길이가 5자 이상인지 확인
        print(isfriendCodeValid);
      });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '추천인 코드 입력', // 중앙 제목
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              SizedBox(height: 15),
              CommonAskLabel(text: '추천인 코드'),
              CustomTextFormField(
                controller: friendCodeController,
                onChanged: checkFriendCodeEnabled,
                showClearIcon: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: NextButton(
                    onPressed: () async {
                      if (friendCodeController.text.trim().length < 5) {
                        showDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: Text("알림"),
                            content: Text("유효한 코드가 아닙니다!"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("확인"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        );
                      }
                      Navigator.of(context).pop(); // Bottom sheet 닫기
                      FriendRecommendCodeModel friendCodeModel =
                          FriendRecommendCodeModel(
                              code:
                                  friendCodeController.text.trim().toString());
                      try {
                        var response = await ref
                            .read(pointProvider.notifier)
                            .repository
                            .registerCode(
                                friendRecommendCodeModel: friendCodeModel);

                        if (response.code == 200) {
                          // 사용자 정보 갱신 요청
                          ref.read(userMeProvider.notifier).getMe();
                          ref.read(pointProvider.notifier).paginate();
                          showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text("알림"),
                              content: Text("포인트가 적립되었습니다!"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("확인"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                        } else if (response.code == 400) {
                          showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text("알림"),
                              content: Text("등록되지 않은 추천인 코드 입니다!"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("확인"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                        }
                      } catch (error) {
                        // 에러 처리
                        print("에러 발생: $error");
                        showDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: Text("알림"),
                            content: Text("등록되지 않은 추천인 코드 입니다!"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("확인"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    buttonName: '입력하기',
                    isButtonEnabled: true),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // LoginUserProvider user;

    final userState = ref.watch(userMeProvider);
    UserModel? user;
    if (userState is UserModel) {
      user = userState; // UserModel로 캐스팅
    }
    // user 또는 userPointState가 로딩 중일 때 로딩 인디케이터를 표시
    if (user == null) {
      print('로딩중...');
      return SplashScreen();
    } else {
      return DefaultLayout(
        title: '친구 초대',
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                width: 340,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(
                    width: 1.0,
                    color: Colors.white12,
                  ),
                  borderRadius: BorderRadius.circular(5), // 모서리를 깎는 부분
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '친구에게 추천하면',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '두 분 모두 적립금을 드립니다.',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/img/money.png',
                        width: 40,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FriendButton(
              text: '친구 추천 코드 복사',
              imageAsset: 'assets/img/link.png',
              color: SUB_COLOR2,
              onPressed: () async {
                var response =
                    await ref.read(pointProvider.notifier).repository.getCode();
                showDialog(
                  context: context,
                  builder: (context) => Container(
                    child: CupertinoAlertDialog(
                      title: Text('코드 복사 완료'),
                      content: Text(
                        '친구 초대 버튼으로 코드를 전달해 주세요!',
                      ),
                      actions: <Widget>[
                        CupertinoButton(
                          child: Text('확인'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    ),
                  ),
                );
                ref.read(referralCodeProvider.notifier).state = response.data;
              },
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: FriendButton(
                  text: '카톡으로 친구 초대',
                  imageAsset: 'assets/img/kakao.png',
                  color: YELLOW_COLOR,
                  onPressed: () async {
                    try {
                      // referralCodeProvider에서 저장된 추천인 코드를 가져옵니다.
                      String? referralCode = ref.read(referralCodeProvider);

                      // 추천인 코드를 포함한 새로운 TextTemplate를 만듭니다.
                      // 추천인 코드가 없으면, 기본 메시지(defaultText)를 사용합니다.
                      TextTemplate messageTemplate = referralCode != null
                          ? TextTemplate(
                              text:
                                  '회원 가입 후 추천인 코드 $referralCode를 입력 하면 두분 모두에게 300원의 추가 적립금을 드려요!',
                              link: Link(
                                webUrl: Uri.parse(
                                    'https://apps.apple.com/us/app/인터미션-intermission/id6471970116'),
                                iosExecutionParams: {
                                  'url':
                                      'https://apps.apple.com/us/app/인터미션-intermission/id6471970116'
                                },
                              ),
                            )
                          : defaultText;

                      // 카카오톡 실행 가능 여부 확인
                      bool isKakaoTalkSharingAvailable = await ShareClient
                          .instance
                          .isKakaoTalkSharingAvailable();

                      if (isKakaoTalkSharingAvailable) {
                        try {
                          Uri uri = await ShareClient.instance
                              .shareDefault(template: messageTemplate);
                          await ShareClient.instance.launchKakaoTalk(uri);
                          print('카카오톡 공유 완료');
                        } catch (error) {
                          print('카카오톡 공유 실패 $error');
                        }
                      } else {
                        try {
                          Uri shareUrl = await WebSharerClient.instance
                              .makeDefaultUrl(template: messageTemplate);
                          await launchBrowserTab(shareUrl, popupOpen: true);
                        } catch (error) {
                          print('카카오톡 공유 실패 $error');
                        }
                      }
                    } catch (error) {
                      print('카카오톡 친구 목록 가져오기 실패 $error');
                    }
                  },
                )),
            Divider(color: Colors.grey[200], thickness: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '친구 추천 현황 및 코드 입력',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '가입한 친구',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '총 ${user.friendCount}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: showAddDialog,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '코드 입력하고 포인트 받기',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
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
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
