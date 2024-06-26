import 'package:app_settings/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermission_project/alarm/model/local_notification.dart';
import 'package:intermission_project/alarm/model/firebase_token_model.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/layout/default_layout.dart';
import 'package:intermission_project/firebase/firebase_options.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:intermission_project/user/provider/user_me_provider.dart';
import 'package:intermission_project/user/repository/auth_repository.dart';

void showNotificationSettingsBottomSheet(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        color: Colors.white,
        height: screenHeight * .35,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: SvgPicture.asset(
                'assets/img/alarm_setting.svg',
                height: 50,
                width: 50,
              )),
              Center(
                child: Text(
                  "알림 설정은 '설정 > 알림 > 인터미션'에서\n변경 가능해요!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth*0.4,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PRIMARY_COLOR,
                        width: 1.5,
                      ),
                      color:
                          Colors.white, // White background for the '닫기' button
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        primary: PRIMARY_COLOR, // PRIMARY_COLOR text
                      ),
                      child: Text(
                        '닫기',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: screenWidth*0.4,
                    height: 55,
                    decoration: BoxDecoration(
                      color:
                          PRIMARY_COLOR, // PRIMARY_COLOR background for the '설정하기' button
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: TextButton(
                      onPressed: () {
                        AppSettings.openAppSettings();
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white, // White text
                      ),
                      child: Text(
                        '설정하기',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class AlarmSettingScreen extends ConsumerStatefulWidget {
  const AlarmSettingScreen({super.key});

  @override
  ConsumerState<AlarmSettingScreen> createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends ConsumerState<AlarmSettingScreen>
    with WidgetsBindingObserver {
  bool switchValue1 = false; // 스위치 상태를 관리하는 변수
  bool switchValue2 = false;
  bool switchValue3 = false;
  bool switchValue4 = false;

  Future<bool> requestNotificationPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkNotificationPermissionAndUpdateUI();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 생명주기 이용해보자(WidgetsBindingObserver!)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // 앱이 포그라운드로 돌아올 때 알림 권한 확인
      checkNotificationPermissionAndUpdateUI();
    }
  }

  Future<void> checkNotificationPermissionAndUpdateUI() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.getNotificationSettings();
    setState(() {
      switchValue1 =
          settings.authorizationStatus == AuthorizationStatus.authorized;
    });
  }

  Future<bool> handleNotificationSwitchChange(bool value) async {
    if (value) {
      // Firebase 초기화 및 토큰 가져오기
      final String? firebaseToken = await initializeFirebaseMessaging();
      print('FirebaseToken: $firebaseToken');
      if (firebaseToken != null) {
        print('${firebaseToken} != null');
        await saveTokenToSecureStorage(firebaseToken);
      }

      // 스위치가 켜질 때 권한 요청
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // 권한이 부여됨
        print('알림 권한 부여됨');
        return true;
      } else {
        // 권한 거부됨
        switchValue1 = false;
        print('알림 권한 거부됨');

        try {
          final String? firebaseToken = await readTokenFromSecureStorage();
          if (firebaseToken != null) {
            print('FirebaseToken: $firebaseToken');
            final firebaseTokenModel = FirebaseTokenModel(firebaseToken: firebaseToken);
           final resp =  ref.read(userMeProvider.notifier).deleteToken(firebaseTokenModel);
            if(resp == 200){
              print('Firebase token deleted successfully1');
            }
            print('Firebase token deleted successfully2');
          }
        } catch (e) {
          print('Error deleting Firebase token: $e');
          return false;
        }
        showNotificationSettingsBottomSheet(context);
        return false;
      }
    } else {
      // 스위치가 꺼질 때 모든 관련 스위치를 꺼뜨림
      showNotificationSettingsBottomSheet(context);
      return false;
    }
  }

  Future<void> sendTestNotification() async {
    if (!switchValue1) {
      bool switchStatus = await handleNotificationSwitchChange(true);
      setState(() {
        switchValue1 = switchStatus;
      });
    }
    if (switchValue1) {
      // 테스트 알림 보내기 로직
      FlutterLocalNotification.init();
      Future.delayed(const Duration(seconds: 1),
          FlutterLocalNotification.requestNotificationPermission());
      FlutterLocalNotification.showNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '알림 설정',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '푸시 알림',
                    style: TextStyle(
                      color: BORDER_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoSwitch(
                    value: switchValue1,
                    activeColor: PRIMARY_COLOR,
                    onChanged: (bool value) async {
                      bool switchStatus =
                          await handleNotificationSwitchChange(value);
                      setState(() {
                        switchValue1 = switchStatus;
                        if (!switchStatus) {
                          switchValue2 = false;
                          switchValue3 = false;
                          // 여기에 추가적인 스위치 상태 변경 로직 추가 가능
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '새로운 리서치 추천 알림',
                    style: TextStyle(
                      color: BORDER_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoSwitch(
                    value: switchValue2,
                    activeColor: PRIMARY_COLOR,
                    onChanged: switchValue1
                        ? (bool value) {
                            setState(() {
                              switchValue2 = value;
                            });
                          }
                        : null, // switchValue1이 false일 경우, 스위치 비활성화
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[900],
            thickness: 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '이벤트 알림',
                    style: TextStyle(
                      color: BORDER_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoSwitch(
                    value: switchValue3,
                    activeColor: PRIMARY_COLOR,
                    onChanged: switchValue1
                        ? (bool value) {
                            setState(() {
                              switchValue3 = value;
                            });
                          }
                        : null, // switchValue1이 false일 경우, 스위치 비활성화
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: sendTestNotification,
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '테스트 알림 보내기',
                      style: TextStyle(
                        color: BORDER_COLOR,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: sendTestNotification, // 테스트 알림 보내기 함수 호출
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: GREY_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 여기에 다른 위젯들 추가 가능
        ],
      ),
    );
  }
}

// 백그라운드 메시지를 처리하는 프로세스는 네이티브(Android 및 Apple) 플랫폼과 웹 기반 플랫폼에서 다르다
// Apple 플랫폼 및 Android
// onBackgroundMessage 핸들러를 등록하여 백그라운드 메시지를 처리
// 이를 통해 애플리케이션이 실행되지 않고 있더라도 메시지를 처리
// 백그라운드 메시지 핸들러와 관련하여 유의해야 할 몇 가지 사항
// 익명 함수가 아니어야함
// 최상위 수준 함수여야 합(예: 초기화가 필요한 클래스 메서드가 아님).
@pragma(
    'vm:entry-point') //메시지 핸들러는 함수 선언 바로 위에 @pragma('vm:entry-point')로 주석을 달아야 합니다(그렇지 않으면 출시 모드의 경우 트리 쉐이킹 중에 삭제될 수 있음).
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<String?> initializeFirebaseMessaging() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // 메시징 서비스 기본 객체 생성
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Firebase 메시징 권한 요청
  // 첫 빌드시, 권한 확인하기
  // 아이폰은 무조건 받아야 하고, 안드로이드는 상관 없음. 따로 유저가 설정하지 않는 한,
  // 자동 권한 확보 상태
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print(settings.authorizationStatus);

  print('User granted permission: ${settings.authorizationStatus}');

  /// 13버전
  await FirebaseMessaging.instance.requestPermission(
    badge: true,
    alert: true,
    sound: true,
  );

  // Android용 알림 채널 설정
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    showBadge: false,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // 로컬 알림 초기화
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(defaultPresentBadge: false),
    ),
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    sound: true,
    badge: true,
    alert: true,
  );
  FlutterAppBadger.removeBadge();

  // foreground 푸시 알림 핸들링
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    print('Got a message whilst in the foreground');
    print('Message data: ${message.data}');

    if (message.notification != null && android != null) {
      print('hello@@@@');
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification?.title,
        notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
          ),
        ),
      );
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // Firebase 토큰 발급
  String? firebaseToken = await messaging.getToken();
  print("FirebaseToken: $firebaseToken");

  return firebaseToken;
}

Future<void> saveTokenToSecureStorage(String? token) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: 'firebase_token', value: token);
}
