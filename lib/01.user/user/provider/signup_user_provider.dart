import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupUserProvider = ChangeNotifierProvider((ref) => SignupUserNotifier());

class SignupUserNotifier extends ChangeNotifier {
  String? userTpCd;
  String? userNm;
  String? pwd;
  String? bankAccount;
  String? accountNumber;
  String? birthDay;
  String? genderCd;
  String? hpNum;
  String? email;
  String? jobCd;
  String? asignJobCd;
  String? jobGrdNm;
  String? wedTpCd;
  String? housTpCd;
  String? petYn;
  String? petTpCd;
  String? petNm;
  String? occpSidoCd;
  String? occpSigunguCd;
  String? researchSidoCd;
  String? researchSigunguCd;
  String? oflResRwdTpCd;
  String? onlResRwdTpCd;
  String? mainUseOnlSvcCn;
  String? hobySubs;
  String? rcmdUserCd;
  String? isAgreeYn;
  String? delYn;

  void setUserTpCd(String? value) {
    userTpCd = value;
    notifyListeners();
  }

  void setUserNm(String? value) {
    userNm = value;
    notifyListeners();
  }

  void setPwd(String? value) {
    pwd = value;
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

  void setGenderCd(String? value) {
    genderCd = value;
    notifyListeners();
  }

  void setHpNum(String? value) {
    hpNum = value;
    notifyListeners();
  }

  void setEmail(String? value) {
    email = value;
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

  // void setJobGrdNm(String? value) {
  //   jobGrdNm = value;
  //   notifyListeners();
  // }

  void setJobGrdNm(String? value) {
    if (value == null || value.trim().isEmpty) {
      jobGrdNm = "";
    } else {
      jobGrdNm = value.trim();
    }
    notifyListeners();
  }


  void setWedTpCd(String? value) {
    wedTpCd = value;
    notifyListeners();
  }

  void setHousTpCd(String? value) {
    housTpCd = value;
    notifyListeners();
  }

  void setPetYn(String? value) {
    petYn = value;
    notifyListeners();
  }

  void setPetTpCd(String? value) {
    petTpCd = value;
    notifyListeners();
  }

  void setPetNm(String? value) {
      if (value == null || value.trim().isEmpty) {
        petNm = "";
      } else {
        petNm = value.trim();
      }
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

  void setResearchSidoCd(String? value) {
    researchSidoCd = value;
    notifyListeners();
  }

  void setResearchSigunguCd(String? value) {
    researchSigunguCd = value;
    notifyListeners();
  }

  void setOflResRwdTpCd(String? value) {
    oflResRwdTpCd = value;
    notifyListeners();
  }

  void setOnlResRwdTpCd(String? value) {
    onlResRwdTpCd = value;
    notifyListeners();
  }

  void setMainUseOnlSvcCn(String? value) {
    mainUseOnlSvcCn = value;
    notifyListeners();
  }

  void setHobySubs(String? value) {
    hobySubs = value;
    notifyListeners();
  }

  void setRcmdUserCd(String? value) {
    rcmdUserCd = value;
    notifyListeners();
  }

  void setIsAgreeYn(String? value) {
    isAgreeYn = value;
    notifyListeners();
  }

  void setDelYn(String? value) {
    delYn = value;
    notifyListeners();
  }
}
