import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flirta/common/domain/entites/user/user.dart' as entities;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppStateService {
  Locale currentLocale = const Locale('en', 'EN');
  entities.User currentUser = entities.User.empty();
  firebase.User? adminUser;

  bool get isAuth => (adminUser != null || currentUser != entities.User.empty())
      ? true
      : false;
  bool get isPremium => true;
  bool get isAdmin => adminUser != null;

  void clearCurrentUser() {
    currentUser = entities.User.empty();
  }
}
