import 'package:flirta/common/domain/entites/user/user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppStateService {
  Locale currentLocale = const Locale('en', 'EN');
  User currentUser = User.empty();

  bool get isAuth => currentUser != User.empty() ? true : false;

  void clearCurrentUser() {
    currentUser = User.empty();
  }
}
