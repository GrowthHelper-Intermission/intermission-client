import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/storage/secure_storage.dart';
import 'package:intermission_project/user/provider/user_me_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);
  dio.interceptors.add(
    CustomInterceptor(
      storage: storage,
      ref: ref,
    ),
  );
  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.ref,
    required this.storage,
  });

// 1) 요청을 보낼때
  //요청이 보내질때마다 만약 요청의 Header에 accessToken : true 라는 값이 있다면?
  //storage에서 실제토큰을 가져와서 authorization: Bearer $token으로 헤더변경한다

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      print('accessToken: $token');
      //실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');
      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      //실제 토근으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

// 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    print('Data: ${response.data}');
    return super.onResponse(response, handler);
  }

// 3) 에러가 났을때(어떤 상황 캐치하고 싶은지 분기처리가 중요함)
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401에러 났을때(토큰 만료, 토큰 오타, status code)
    // 토큰 재발급 받는 시도하고 토큰이 재발급되면
    // 다시 새로운 토큰 요청
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    print('here?');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    //refreshToken 아예 없으면 당연히 에러 던진다
    if (refreshToken == null) {
      //에러 던질때는 reject 사용
      print('refreshNull?');
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401; //401
    final isStatus403 = err.response?.statusCode == 403; //403
    final isStatus404 = err.response?.statusCode == 404; //403
    final isPathRefresh = err.requestOptions.path == '/auth/token';
    final isStatus500 = err.response?.statusCode == 500; // 추가: 500 에러 체크



    print(refreshToken);
    print(accessToken);
    //토큰을 refresh하려는 의도가 아니었는데 403에러가 났다면?
    // if ((isStatus403 && !isPathRefresh) ||(isStatus500 && !isPathRefresh)) {
    if ((isStatus403 && !isPathRefresh) || (isStatus404 && !isPathRefresh)) {
      final dio = Dio();
      try {
        print('token refresh start');
        final resp = await dio.get(
          'https://growthhelper-intermission.com/api/user/me', //수정
          options: Options(
            headers: {
              'Authorization-refresh': 'Bearer $refreshToken',
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );
        //refreshtoken으로 accesstoken발급 과정에서 에러가 낫다면?

        // final accessToken = resp.data['accessToken'];
        
        final newAccessToken = resp.headers.value('Authorization');

        print('NEW NEW NEW! $accessToken');

        final options = err.requestOptions; //요청을보낼때 필요한 모든값은 equestOptions에 잇다

        //토큰 변경하기
        options.headers.addAll({
          'authorization': 'Bearer $newAccessToken',
        });
        //storage 업데이트 당연히 필요
        await storage.write(key: ACCESS_TOKEN_KEY, value: newAccessToken);

        //요청 재전송(원래 요청을 토큰만 변경시킨채로 다시보냄)
        final response = await dio.fetch(options);

        return handler.resolve(response); //외부에서는 이 과정만보임 (요청이 잘 끝났음 의미)
      } on DioError catch (e) {
        print('DioError Occurred: ${e.message}');
        ref.read(userMeProvider.notifier).logout();
        // ref.read(authProvider.notifier).logout();
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}