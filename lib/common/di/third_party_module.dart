//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_remote_config/firebase_remote_config.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:google_sign_in/google_sign_in.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venice_client/venice_client.dart';

import '../router/client_router.dart' as client;
import '../router/admin_router.dart' as admin;
import '../router/observers/auth_analytics_observer.dart';
import '../source/database/database_manager.dart';
import 'package:deepseek_client/deepseek_client.dart';

@module
abstract class ThirdPartyModule {
  GoRouter router(AuthAnalyticsObserver analyticsObserver) {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        return GoRouter(
          navigatorKey: client.rootNavigatorKey,
          routes: client.$appRoutes,
          observers: [analyticsObserver],
        );
      }
    }
    return GoRouter(
      navigatorKey: admin.rootNavigatorKeyAdmin,
      routes: admin.$appRoutes,
      observers: [analyticsObserver],
    );
  }

  @singleton
  Logger get logger => Logger();

  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker.createInstance();

  @preResolve
  Future<SharedPreferences> get storage => SharedPreferences.getInstance();

  @singleton
  AppDatabase get dataBase => AppDatabase();

  FirebaseAuth get auth => FirebaseAuth.instance;

  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @singleton
  FirebaseRemoteConfig get remoteConfig => FirebaseRemoteConfig.instance;

  @singleton
  FirebaseStorage get firestorage => FirebaseStorage.instance;

  @singleton
  DeepseekClient get deepseekClient => DeepseekClient();

  @singleton
  VeniceClient get veniceClient => VeniceClient();
}
