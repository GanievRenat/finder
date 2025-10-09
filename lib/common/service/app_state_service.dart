import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppStateService {
  User? currentUser;
  bool premiumAccess = false;
  Locale currentLocale = const Locale('en', 'EN');

  bool get isAuth => currentUser != null ? true : false;
  bool get showedOnboarding => false;

  void clearCurrentUser() {
    currentUser = null;
    premiumAccess = false;
  }
}
