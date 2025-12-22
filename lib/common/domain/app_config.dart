enum LocalKeies {
  localProfileKey,
  localRegistrationFormKey,
  localFilterStateKey,
  localPersonsPerDay,
  localRequestIds,
}

abstract class AppConfig {
  String get baseUrl;
  String get host;
  String get defaultLocale;
  List<String> get localies;
  int get limitRequestSpicyPhotoPerDay;
  int get limitRequestBananaPhotoPerDay;

  /// Если переменная установлена в true, то будет показан экран с онбордингом
  bool get showOnboarding;
  String get termsURL;
  String get privatURL;
  String get aboutURL;

  Map<LocalKeies, String> get localKeies;
}
