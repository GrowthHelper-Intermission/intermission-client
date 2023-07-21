import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InterviewsProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _interviews = [];

  InterviewsProvider() {
    loadInterviews();
  }

  List<Map<String, dynamic>> get interviews => _interviews;

  // Firestore에서 인터뷰 정보를 불러오는 메서드
  void loadInterviews() async {
    FirebaseFirestore.instance.collection('interviews').get().then((querySnapshot) {
      _interviews = querySnapshot.docs.map((doc) => doc.data()).toList();
      notifyListeners();
    });
  }

  // Firestore에 새 인터뷰를 추가하는 메서드
  void addInterview(Map<String, dynamic> newInterview) async {
    FirebaseFirestore.instance.collection('interviews').add(newInterview).then((_) {
      loadInterviews();
    });
  }

  // Firestore에서 특정 인터뷰를 삭제하는 메서드
  void deleteInterview(String interviewId) async {
    FirebaseFirestore.instance.collection('interviews').doc(interviewId).delete().then((_) {
      loadInterviews();
    });
  }
}
