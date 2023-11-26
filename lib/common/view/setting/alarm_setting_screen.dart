import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intermission_project/01.user/user/model/alarm_model.dart';
import 'package:intermission_project/01.user/user/model/notification.dart';
import 'package:intermission_project/01.user/user/provider/alarm_provider.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/firebase_options.dart';

class AlarmSettingScreen extends ConsumerStatefulWidget {
  const AlarmSettingScreen({super.key});

  @override
  ConsumerState<AlarmSettingScreen> createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends ConsumerState<AlarmSettingScreen> {
  bool switchValue1 = false; // 스위치 상태를 관리하는 변수
  bool switchValue2 = false;
  bool switchValue3 = false;
  bool switchValue4 = false;

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
        print('알림 권한 거부됨');
        return false;
      }
    } else {
      // 스위치가 꺼질 때 권한 거부 처리 (필요한 경우)
      // ...
      return false;
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
                    onChanged: (bool value) {
                      setState(() {
                        switchValue2 = value;
                      });
                    },
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
                    onChanged: (bool value) {
                      setState(() {
                        switchValue3 = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      onTap: () async {
                        // AlarmModel alarmModel = AlarmModel(body: '테스트 알림이 도착했습니다!', title: '테스트 알림');
                        // ref
                        //     .read(alarmStateNotifierProvider.notifier).repository.testAlarm(alarmModel: alarmModel);
                        // print('테스트 알림 보내기 요청');
                        FlutterLocalNotification.init();
                        Future.delayed(
                            const Duration(seconds: 1),
                            FlutterLocalNotification
                                .requestNotificationPermission());
                        FlutterLocalNotification.showNotification();
                      },
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
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print(settings.authorizationStatus);

  print('User granted permission: ${settings.authorizationStatus}');

  /// 13버전
  FirebaseMessaging.instance.requestPermission(
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
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    sound: true,
    badge: true,
    alert: true,
  );

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
