import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/friend_button.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_share.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

final TextTemplate defaultText = TextTemplate(
  text: '회원 가입 후 추천인 코드를 입력 하면 두분 모두에게 300원의 추가 적립금을 드려요!',
  link: Link(
    webUrl: Uri.parse('https: //developers.kakao.com'),
    mobileWebUrl: Uri.parse('https: //developers.kakao.com'),
  ),
);

final FeedTemplate defaultFeed = FeedTemplate(
  content: Content(
    title: '딸기 치즈 케익',
    description: '#케익 #딸기 #삼평동 #카페 #분위기 #소개팅',
    imageUrl: Uri.parse(
        'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
    link: Link(
        webUrl: Uri.parse('https://developers.kakao.com'),
        mobileWebUrl: Uri.parse('https://developers.kakao.com')),
  ),
  itemContent: ItemContent(
    profileText: 'Kakao',
    profileImageUrl: Uri.parse(
        'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
    titleImageUrl: Uri.parse(
        'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
    titleImageText: 'Cheese cake',
    titleImageCategory: 'cake',
    items: [
      ItemInfo(item: 'cake1', itemOp: '1000원'),
      ItemInfo(item: 'cake2', itemOp: '2000원'),
      ItemInfo(item: 'cake3', itemOp: '3000원'),
      ItemInfo(item: 'cake4', itemOp: '4000원'),
      ItemInfo(item: 'cake5', itemOp: '5000원')
    ],
    sum: 'total',
    sumOp: '15000원',
  ),
  social: Social(likeCount: 286, commentCount: 45, sharedCount: 845),
  buttons: [
    Button(
      title: '웹으로 보기',
      link: Link(
        webUrl: Uri.parse('https: //developers.kakao.com'),
        mobileWebUrl: Uri.parse('https: //developers.kakao.com'),
      ),
    ),
    Button(
      title: '앱으로보기',
      link: Link(
        androidExecutionParams: {'key1': 'value1', 'key2': 'value2'},
        iosExecutionParams: {'key1': 'value1', 'key2': 'value2'},
      ),
    ),
  ],
);

class FriendInviteScreen extends StatelessWidget {
  FriendInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // LoginUserProvider user;

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
            text: '친구 추천 링크 복사',
            imageAsset: 'assets/img/link.png',
            color: SUB_COLOR2,
            onPressed: () {},
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: FriendButton(
                text: '카톡으로 친구 초대',
                imageAsset: 'assets/img/kakao.png',
                color: YELLOW_COLOR,
                onPressed: () async {
                  // 카카오톡 친구 목록 가져오기 및 메시지 보내기 로직
                  try {
                    // 카카오톡 실행 가능 여부 확인
                    bool isKakaoTalkSharingAvailable = await ShareClient
                        .instance
                        .isKakaoTalkSharingAvailable();

                    if (isKakaoTalkSharingAvailable) {
                      try {
                        Uri uri = await ShareClient.instance
                            .shareDefault(template: defaultText);
                        await ShareClient.instance.launchKakaoTalk(uri);
                        print('카카오톡 공유 완료');
                      } catch (error) {
                        print('카카오톡 공유 실패 $error');
                      }
                    } else {
                      try {
                        Uri shareUrl = await WebSharerClient.instance
                            .makeDefaultUrl(template: defaultText);
                        await launchBrowserTab(shareUrl, popupOpen: true);
                      } catch (error) {
                        print('카카오톡 공유 실패 $error');
                      }
                    }
                    // 이후의 로직 처리
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
                  '친구 추천 현황',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('가입한 친구'),
                    Text(
                      '총 0명',
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 1,
                  width: 350,
                  color: Colors.grey[200],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('이번달에 가입한 친구'),
                    Text(
                      '0명',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
