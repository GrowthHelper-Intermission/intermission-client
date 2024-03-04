import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

//SharedPreferences 사용 변수들 (key)
final String darkModeState = dotenv.env['DARK_MODE_STATE']!;
final String userId = dotenv.env['USER_ID']!;
final String userPassword = dotenv.env['USER_PASSWORD']!;
//const String loginState = "login_state";
final String autoLoginKey = dotenv.env['AUTO_LOGIN_KEY']!;

final ACCESS_TOKEN_KEY = dotenv.env['ACCESS_TOKEN_KEY']!;
final REFRESH_TOKEN_KEY = dotenv.env['REFRESH_TOKEN_KEY']!;

// localhost
final emulatorIp = '10.0.2.2:3000';
final simulatorIp = '127.0.0.1:3000';

// final ip = Platform.isAndroid ? emulatorIp : simulatorIp;

final ip = dotenv.env['DEV_IP']!;

final serviceUrl = dotenv.env['SERVICE_URL']!;
final privateUrl = dotenv.env['PRIVATE_URL']!;

