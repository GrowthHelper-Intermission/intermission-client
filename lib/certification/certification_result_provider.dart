import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CertificationResultState {
  bool isLoading;
  bool isSuccess;
  String? errorMessage;

  CertificationResultState({
    this.isLoading = true,
    this.isSuccess = false,
    this.errorMessage,
  });

  CertificationResultState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return CertificationResultState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class CertificationResultNotifier extends StateNotifier<CertificationResultState> {
  CertificationResultNotifier() : super(CertificationResultState());
  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }
  void setSuccess(bool success) => state = state.copyWith(isSuccess: success);
  void setErrorMessage(String? message) => state = state.copyWith(errorMessage: message);
}

final certificationResultProvider = StateNotifierProvider<CertificationResultNotifier, CertificationResultState>(
      (ref) => CertificationResultNotifier(),
);

