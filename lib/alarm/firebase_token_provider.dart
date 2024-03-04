import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/alarm/firebase_token_model.dart';

final firebaseTokenProvider = StateNotifierProvider<FirebaseTokenNotifier, FirebaseTokenModel>((ref) {
  return FirebaseTokenNotifier();
});


class FirebaseTokenNotifier extends StateNotifier<FirebaseTokenModel> {
  FirebaseTokenNotifier() : super(FirebaseTokenModel(firebaseToken: ''));

  void setToken(String newToken) {
    state = FirebaseTokenModel(firebaseToken: newToken);
  }

  String? getToken() {
    return state.firebaseToken;
  }
}
