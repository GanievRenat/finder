//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_remote_config/firebase_remote_config.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:google_sign_in/google_sign_in.dart';

import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/app_router.dart';
import '../router/observers/analytics_observer.dart';

@module
abstract class ThirdPartyModule {
  GoRouter router(AnalyticsObserver analyticsObserver) => GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: $appRoutes,
    observers: [analyticsObserver],
  );

  @singleton
  Logger get logger => Logger();

  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker.createInstance();

  @preResolve
  Future<SharedPreferences> get storage => SharedPreferences.getInstance();

  /*FirebaseAuth get auth => FirebaseAuth.instance;

  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @singleton
  FirebaseRemoteConfig get remoteConfig => FirebaseRemoteConfig.instance;

  @singleton
  GoogleSignIn get googleSignIn => GoogleSignIn.instance;*/
}
