import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';

import 'package:flutter/foundation.dart';

final signupUserProvider =
ChangeNotifierProvider((ref) => SignupUserNotifier());

class SignupUserNotifier extends ChangeNotifier {
  SignupUserModel _userData = SignupUserModel();

  SignupUserModel get getUserData => _userData;

  String? ofcNm;
  String? jobGrdNm;
  String? ceoYn;
  String? id;
  String? userTpCd;
  String? userNm;
  String? userId;
  String? pwd;
  String? joinDay;
  String? bankAccount;
  String? accountNumber;
  String? birthDay;
  String? genderCd;
  String? hpNum;
  String? email;
  String? emailVerfYn;
  String? jobCd;
  String? asignJobCd;
  String? jobNm;
  String? wedTpCd;
  String? housTpCd;
  String? petYn;
  String? petTpCd;
  String? petNm;
  String? occpSidoCd;
  String? occpSigunguCd;
  String? intvSidoCd;
  String? intvSigunguCd;
  String? oflIntvRwdTpCd;
  String? onlIntvRwdTpCd;
  String? mainUseOnlSvcCn;
  String? hobySubs;
  String? rcmdUserCd;
  String? isAgreeYn;
  String? isAgreeDt;
  String? empYn;
  String? empNo;
  String? delYn;
  String? frstRegtDt;
  String? finlUpdtDt;

  void setId(String? id) {
    this.id = id;
    notifyListeners();
  }

  void setUserTpCd(String? userTpCd) {
    this.userTpCd = userTpCd;
    notifyListeners();
  }

  void setUserNm(String? userNm) {
    this.userNm = userNm;
    notifyListeners();
  }

  void setUserId(String? userId) {
    this.userId = userId;
    notifyListeners();
  }

  void setPwd(String? pwd) {
    this.pwd = pwd;
    notifyListeners();
  }

  void setJoinDay(String? joinDay) {
    this.joinDay = joinDay;
    notifyListeners();
  }

  void setBankAccount(String? bankAccount) {
    this.bankAccount = bankAccount;
    notifyListeners();
  }

  void setAccountNumber(String? accountNumber) {
    this.accountNumber = accountNumber;
    notifyListeners();
  }

  void setBirthDay(String? birthDay) {
    this.birthDay = birthDay;
    notifyListeners();
  }

  void setGenderCd(String? genderCd) {
    this.genderCd = genderCd;
    notifyListeners();
  }

  void setHpNum(String? hpNum) {
    this.hpNum = hpNum;
    notifyListeners();
  }

  void setEmail(String? email) {
    this.email = email;
    notifyListeners();
  }

  void setEmailVerfYn(String? emailVerfYn) {
    this.emailVerfYn = emailVerfYn;
    notifyListeners();
  }

  void setJobCd(String? jobCd) {
    this.jobCd = jobCd;
    notifyListeners();
  }

  void setAsignJobCd(String? asignJobCd) {
    this.asignJobCd = asignJobCd;
    notifyListeners();
  }

  void setJobGrdNm(String? jobGrdNm) {
    this.jobGrdNm = jobGrdNm;
    notifyListeners();
  }

  void setWedTpCd(String? wedTpCd) {
    this.wedTpCd = wedTpCd;
    notifyListeners();
  }

  void setHousTpCd(String? housTpCd) {
    this.housTpCd = housTpCd;
    notifyListeners();
  }

  void setPetYn(String? petYn) {
    this.petYn = petYn;
    notifyListeners();
  }

  void setPetTpCd(String? petTpCd) {
    this.petTpCd = petTpCd;
    notifyListeners();
  }

  void setPetNm(String? petNm) {
    this.petNm = petNm;
    notifyListeners();
  }

  void setOccpSidoCd(String? occpSidoCd) {
    this.occpSidoCd = occpSidoCd;
    notifyListeners();
  }

  void setOccpSigunguCd(String? occpSigunguCd) {
    this.occpSigunguCd = occpSigunguCd;
    notifyListeners();
  }

  void setIntvSidoCd(String? intvSidoCd) {
    this.intvSidoCd = intvSidoCd;
    notifyListeners();
  }

  void setIntvSigunguCd(String? intvSigunguCd) {
    this.intvSigunguCd = intvSigunguCd;
    notifyListeners();
  }

  void setOflIntvRwdTpCd(String? oflIntvRwdTpCd) {
    this.oflIntvRwdTpCd = oflIntvRwdTpCd;
    notifyListeners();
  }

  void setOnlIntvRwdTpCd(String? onlIntvRwdTpCd) {
    this.onlIntvRwdTpCd = onlIntvRwdTpCd;
    notifyListeners();
  }

  void setMainUseOnlSvcCn(String? mainUseOnlSvcCn) {
    this.mainUseOnlSvcCn = mainUseOnlSvcCn;
    notifyListeners();
  }

  void setHobySubs(String? hobySubs) {
    this.hobySubs = hobySubs;
    notifyListeners();
  }

  void setRcmdUserCd(String? rcmdUserCd) {
    this.rcmdUserCd = rcmdUserCd;
    notifyListeners();
  }

  void setIsAgreeYn(String? isAgreeYn) {
    this.isAgreeYn = isAgreeYn;
    notifyListeners();
  }

  void setIsAgreeDt(String? isAgreeDt) {
    this.isAgreeDt = isAgreeDt;
    notifyListeners();
  }

  void setEmpYn(String? empYn) {
    this.empYn = empYn;
    notifyListeners();
  }

  void setEmpNo(String? empNo) {
    this.empNo = empNo;
    notifyListeners();
  }

  void setDelYn(String? delYn) {
    this.delYn = delYn;
    notifyListeners();
  }

  void setFrstRegtDt(String? frstRegtDt) {
    this.frstRegtDt = frstRegtDt;
    notifyListeners();
  }

  void setFinlUpdtDt(String? finlUpdtDt) {
    this.finlUpdtDt = finlUpdtDt;
    notifyListeners();
  }

}
