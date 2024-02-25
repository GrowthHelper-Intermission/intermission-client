import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupUserProvider = ChangeNotifierProvider((ref) => SignupUserNotifier());

class SignupUserNotifier extends ChangeNotifier {
  String? email;
  String? password;
  String? isTermsAgreed;
  String? isPrivacyAgreed;
  String? jobCd;
  String? asignJobCd;
  String? wedCd;
  String? genderCd;
  String? occpSidoCd;
  String? occpSigunguCd;
  String? housTpCd;
  String? userCd;
  String? userNm;
  String? bankAccount;
  String? accountNumber;
  String? birthDay;
  String? birthday;
  String? uniqueKey;
  String? certifiedAt;
  String? phoneNumber;
  String? userName;
  bool? isSignup;
  String? taskCd; /// 직업명
  String? industryCd;/// 사업
  String? industryDetailCd; /// 사업상세

  void setTaskCd(String value) {
    taskCd = value;
    notifyListeners();
  }

  void setIndustryCd(String value){
    industryCd = value;
    notifyListeners();
  }

  void setIndustryDetail(String value){
    industryDetailCd = value;
    notifyListeners();
  }

  /// 회원가입시 중복 API 요청 방지용 isSignup
  void setIsSignupAction(bool value){
    isSignup = value;
    notifyListeners();
  }

  void setEmail(String? value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String? value) {
    password = value;
    notifyListeners();
  }

  void setIsTermsAgreed(String? value) {
    isTermsAgreed = value;
    notifyListeners();
  }

  void setIsPrivacyAgreed(String? value) {
    isPrivacyAgreed = value;
    notifyListeners();
  }

  void setJobCd(String? value) {
    jobCd = value;
    notifyListeners();
  }

  void setAsignJobCd(String? value) {
    asignJobCd = value;
    notifyListeners();
  }

  void setWedCd(String? value) {
    wedCd = value;
    notifyListeners();
  }

  void setGenderCd(String? value) {
    genderCd = value;
    notifyListeners();
  }

  void setOccpSidoCd(String? value) {
    occpSidoCd = value;
    notifyListeners();
  }

  void setOccpSigunguCd(String? value) {
    occpSigunguCd = value;
    notifyListeners();
  }

  void setHouseCd(String? value) {
    housTpCd = value;
    notifyListeners();
  }

  void setUserCd(String? value) {
    userCd = value;
    notifyListeners();
  }

  void setUserNm(String? value) {
    userNm = value;
    notifyListeners();
  }

  void setBankAccount(String? value) {
    bankAccount = value;
    notifyListeners();
  }

  void setAccountNumber(String? value) {
    accountNumber = value;
    notifyListeners();
  }

  void setBirthDay(String? value) {
    birthDay = value;
    notifyListeners();
  }

  void setBirthday(String? value) {
    birthday = value;
    notifyListeners();
  }

  void setUniqueKey(String? value) {
    uniqueKey = value;
    notifyListeners();
  }

  void setCertifiedAt(String? value) {
    certifiedAt = value;
    notifyListeners();
  }

  void setPhoneNumber(String? value) {
    phoneNumber = value;
    notifyListeners();
  }

  void setUsername(String? value) {
    userName = value;
    notifyListeners();
  }
}
