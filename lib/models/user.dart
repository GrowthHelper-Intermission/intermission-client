import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUserProvider extends ChangeNotifier {
  String emailAccount = "";
  String password = "";
  String name = "";
  String createdTime = "";
  String gender = "";
  String phoneNumber = "";
  int age = 0;
  String job = "";
  bool isMarried = false;
  String residenceType = "";
  bool isRaisePet = false;
  String kindOfPet = "";
  String residenceArea = "";
  String interviewPossibleArea = "";
  String interviewReward = "";
  String oftenUsingService = "";
  String hobby = "";
  String recommendWho = "";
  int userPoint = 0;
  bool isAgree = true;
  bool autoLogin = false;

  LoginUserProvider();

  void setEmailAccount(String emailAccount) {
    this.emailAccount = emailAccount;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setCreatedTime(String createdTime) {
    this.createdTime = createdTime;
    notifyListeners();
  }

  void setGender(String gender) {
    this.gender = gender;
    notifyListeners();
  }

  void setAge(int age) {
    this.age = age;
    notifyListeners();
  }

  void setJob(String job) {
    this.job = job;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber){
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setIsMarried(bool isMarried) {
    this.isMarried = isMarried;
    notifyListeners();
  }

  void setResidenceType(String residenceType) {
    this.residenceType = residenceType;
    notifyListeners();
  }

  void setIsRaisingPet(bool isRaisePet) {
    this.isRaisePet = isRaisePet;
    notifyListeners();
  }

  void setKindOfPet(String kindOfPet) {
    this.kindOfPet = kindOfPet;
    notifyListeners();
  }

  void setResidenceArea(String residenceArea) {
    this.residenceArea = residenceArea;
    notifyListeners();
  }

  void setInterviewPossibleArea(String interviewPossibleArea) {
    this.interviewPossibleArea = interviewPossibleArea;
    notifyListeners();
  }

  void setInterviewReward(String interviewReward) {
    this.interviewReward = interviewReward;
    notifyListeners();
  }

  void setOftenUsingService(String oftenUsingService) {
    this.oftenUsingService = oftenUsingService;
    notifyListeners();
  }

  void setHobby(String hobby) {
    this.hobby = hobby;
    notifyListeners();
  }

  void setRecommendWho(String recommendWho) {
    this.recommendWho = recommendWho;
    notifyListeners();
  }

  void setUserPoint(int userPoint) {
    this.userPoint = userPoint;
    notifyListeners();
  }

  void setIsAgree(bool isAgree) {
    this.isAgree = isAgree;
    notifyListeners();
  }

  void setPoint(int userPoint){
    this.userPoint = userPoint;
    notifyListeners();
  }

  void setAutoLogin(bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('autoLogin', value);
    this.autoLogin = value;
    notifyListeners();
  }

  LoginUserProvider.fromSnapshot(DocumentSnapshot snapshot) {
    emailAccount = snapshot['emailAccount'];
    password = snapshot['password'];
    name = snapshot['name'];
    createdTime = snapshot['createdTime'];
    gender = snapshot['gender'];
    age = snapshot['age'];
    job = snapshot['job'];
    isMarried = snapshot['isMarried'];
    residenceType = snapshot['residenceType'];
    isRaisePet = snapshot['isRaisePet'];
    kindOfPet = snapshot['kindOfPet'] ?? '';
    residenceArea = snapshot['residenceArea'];
    interviewPossibleArea = snapshot['interviewPossibleArea'] ?? '';
    interviewReward = snapshot['interviewReward'];
    oftenUsingService = snapshot['oftenUsingService'] ?? '';
    hobby = snapshot['hobby'] ?? '';
    recommendWho = snapshot['recommendWho'] ?? '';
    userPoint = snapshot['userPoint'];
    isAgree = snapshot['isAgree'];
    autoLogin = snapshot['autoLogin'];
  }

  Map<String, dynamic> toJson() => {
    'emailAccount': emailAccount,
    'password': password,
    'name': name,
    'createdTime': createdTime,
    'gender': gender,
    'age': age,
    'job': job,
    'isMarried': isMarried,
    'residenceType': residenceType,
    'isRaisePet': isRaisePet,
    'kindOfPet': kindOfPet,
    'residenceArea': residenceArea,
    'interviewPossibleArea': interviewPossibleArea,
    'interviewReward': interviewReward,
    'oftenUsingService': oftenUsingService,
    'hobby': hobby,
    'recommendWho': recommendWho,
    'userPoint': userPoint,
    'isAgree': isAgree,
    'autoLogin' : autoLogin,
  };

}



// LoginUserProvider.fromSnapshot(DocumentSnapshot snapshot)
//     : emailAccount = (snapshot.value! as Map<String, dynamic>)['emailAccount'],
//       password = (snapshot.value! as Map<String, dynamic>)['password'],
//       name = (snapshot.value! as Map<String, dynamic>)['name'],
//       createdTime = (snapshot.value! as Map<String, dynamic>)['createdTime'],
//       gender = (snapshot.value! as Map<String, dynamic>)['gender'],
//       age = (snapshot.value! as Map<String, dynamic>)['age'],
//       job = (snapshot.value! as Map<String, dynamic>)['job'],
//       isMarried = (snapshot.value! as Map<String, dynamic>)['isMarried'],
//       residenceType = (snapshot.value! as Map<String, dynamic>)['residenceType'],
//       isRaisePet = (snapshot.value! as Map<String, dynamic>)['isRaisePet'],
//       kindOfPet = (snapshot.value! as Map<String, dynamic>)['kindOfPet'] ?? '',
//       residenceArea = (snapshot.value! as Map<String, dynamic>)['residenceArea'],
//       interviewPossibleArea = (snapshot.value! as Map<String, dynamic>)['interviewPossibleArea'] ?? '',
//       interviewReward = (snapshot.value! as Map<String, dynamic>)['interviewReward'],
//       oftenUsingService = (snapshot.value! as Map<String, dynamic>)['oftenUsingService'] ?? '',
//       hobby = (snapshot.value! as Map<String, dynamic>)['hobby'] ?? '',
//       recommendWho = (snapshot.value! as Map<String, dynamic>)['recommendWho'] ?? '',
//       userPoint = (snapshot.value! as Map<String, dynamic>)['userPoint'],
//       isAgree = (snapshot.value! as Map<String, dynamic>)['isAgree'];
