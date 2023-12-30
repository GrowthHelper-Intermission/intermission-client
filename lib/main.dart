// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intermission_project/01.user/user/provider/firebase_token_provider.dart';
import 'package:intermission_project/common/provider/go_router.dart';
import 'package:intermission_project/common/storage/secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 다언어 설정
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> saveTokenToSecureStorage(String? token) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: 'firebase_token', value: token);
}


void getMyDeviceToken() async{
  final token = await FirebaseMessaging.instance.getToken();
  print('내 디바이스 토큰(여기가 첨이자 마지막):$token');
  await saveTokenToSecureStorage(token);
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: "assets/config/.env");

  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_APP_KEY']);

  /// 친구 초대하기 카카오톡 버튼 클릭시로 변경 필요❗️
  bool isKakaoTalkSharingAvailable = await ShareClient.instance.isKakaoTalkSharingAvailable();

  if (isKakaoTalkSharingAvailable) {
    print('카카오톡으로 공유 가능');
  } else {
    print('카카오톡 미설치: 웹 공유 기능 사용 권장');
  }

  getMyDeviceToken();

  // // Firebase 초기화 및 토큰 가져오기
  // final String? firebaseToken = await initializeFirebaseMessaging();
  // print('FirebaseToken: $firebaseToken');
  // if (firebaseToken != null) {
  //   print('${firebaseToken} != null');
  //   await saveTokenToSecureStorage(firebaseToken);
  // }



  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});



  Widget build(BuildContext context, WidgetRef ref) {
    // final storage = ref.watch(secureStorageProvider);
    final route = ref.watch(routeProvider);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        theme: ThemeData(
          fontFamily: 'Pretendard',
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: route,
        localizationsDelegates: const [
          // 다언어 설정
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English
          const Locale('ko', ''), // Korean
        ],
      ),
    );
  }
}

final firebaseTokenProvider = StateProvider<String?>((ref) {
  return null; // 초기값은 null로 설정합니다.
});



/// 혹시 모르니 보류
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("백그라운드 메시지 처리중... ${message.notification!.body!}");
// }
//
// Future<String?> initializeFirebaseMessaging() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   // 메시징 서비스 기본 객체 생성
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   /// Firebase 메시징 권한 요청
//   // 첫 빌드시, 권한 확인하기
//   // 아이폰은 무조건 받아야 하고, 안드로이드는 상관 없음. 따로 유저가 설정하지 않는 한,
//   // 자동 권한 확보 상태
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   print(settings.authorizationStatus);
//
//   print('User granted permission: ${settings.authorizationStatus}');
//
//   /// 13버전
//   FirebaseMessaging.instance.requestPermission(
//     badge: true,
//     alert: true,
//     sound: true,
//   );
//
//   // Android용 알림 채널 설정
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.max,
//   );
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   // 로컬 알림 초기화
//   await flutterLocalNotificationsPlugin.initialize(
//     const InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     ),
//   );
//
//   // foreground 푸시 알림 핸들링
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//
//     print('Got a message whilst in the foreground');
//     print('Message data: ${message.data}');
//
//     if (message.notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification?.title,
//         notification?.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             icon: android.smallIcon,
//           ),
//         ),
//       );
//       print('Message also contained a notification: ${message.notification}');
//     }
//   });
//
//   // Firebase 토큰 발급
//   String? firebaseToken = await messaging.getToken();
//   print("FirebaseToken: $firebaseToken");
//
//   return firebaseToken;
// }
//



// void initializeNotification() async {
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   // 안드로이드 알림 채널 생성
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(const AndroidNotificationChannel(
//           'high_importance_channel', 'high_importance_notification',
//           importance: Importance.max));
//
//   // local alarm plugin 초기화
//   await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
//     android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//   ));
//
//   // foreground 알림 설정
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//
//   /// 13버전
//   FirebaseMessaging.instance.requestPermission(
//     badge: true,
//     alert: true,
//     sound: true,
//   );
// }
//
// Future<String?> fcmSetting() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   await messaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   print('User granted permission: ${settings.authorizationStatus}');
//
//   // foreground에서의 푸시 알림 표시를 위한 알림중요도 설정(안드로이드)
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'intermission_notification',
//     'intermission_notification',
//     description: '인터미션 알림입니다.',
//     importance: Importance.max,
//   );
//
//   // foreground 에서 푸시 알림표시를 위한 local notifications 설정
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   // foreground 푸시 알림 핸들링
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//
//     print('Got a message whilst in the foreground');
//     print('Message data: ${message.data}');
//
//     if (message.notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification?.title,
//         notification?.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             icon: android.smallIcon,
//           ),
//         ),
//       );
//       print('Message also contained a notification: ${message.notification}');
//     }
//   });
//   // firebase token 발급
//   String? firebaseToken = await messaging.getToken();
//   print("FirebaseToken : ${firebaseToken}");
//   return firebaseToken;
// }
