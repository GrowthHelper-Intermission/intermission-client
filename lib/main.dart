// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intermission_project/common/provider/go_router.dart';
import 'package:intermission_project/common/storage/secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 다언어 설정
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'flavors.dart';

Future<void> saveTokenToSecureStorage(String? token) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: 'firebase_token', value: token);
}


void getMyDeviceToken() async{
  final token = await FirebaseMessaging.instance.getToken();
  print('내 디바이스 토큰(여기가 첨이자 마지막):$token');
  await saveTokenToSecureStorage(token);
}


Future<void> main() async {
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

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
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