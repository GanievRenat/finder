import 'package:flirta/generated/assets.gen.dart';
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
}
