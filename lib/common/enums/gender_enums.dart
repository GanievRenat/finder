import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

enum Gender {
  male('Male'),
  female('Female'),
  nonBinary('Non-binary'),
  none('Everyone');

  const Gender(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;

  ImageProvider getImageProvider() {
    switch (this) {
      case Gender.male:
        return Assets.images.gender.provider();
      case Gender.female:
        return Assets.images.gender.provider();
      case Gender.nonBinary:
        return Assets.images.gender.provider();
      case Gender.none:
        return Assets.images.gender.provider();
    }
  }

  String getGenderName() {
    switch (this) {
      case Gender.male:
        return LocaleKeys.properties_genders_male1.tr();
      case Gender.female:
        return LocaleKeys.properties_genders_female1.tr();
      case Gender.nonBinary:
        return LocaleKeys.properties_genders_nonBinary.tr();
      case Gender.none:
        return LocaleKeys.properties_genders_everyone.tr();
    }
  }

  String getGenderForInterestedName() {
    switch (this) {
      case Gender.male:
        return LocaleKeys.auth_interested_gender_male1.tr();
      case Gender.female:
        return LocaleKeys.auth_interested_gender_female1.tr();
      case Gender.nonBinary:
        return LocaleKeys.auth_interested_gender_nonBinary.tr();
      case Gender.none:
        return LocaleKeys.auth_interested_gender_everyone.tr();
    }
  }
}
