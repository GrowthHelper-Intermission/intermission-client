import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/user/provider/auth_provider.dart';

final routeProvider = Provider<GoRouter>(
  (ref) {
    final provider = ref.read(authProvider);

    return GoRouter(
      // debugLogDiagnostics: true, // 로깅 비활성화
      routes: provider.routes,
      initialLocation: '/splash',
      refreshListenable: provider,
      redirect: provider.redirectLogic,
    );
  },
);
