import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/generated/locale_keys.g.dart';

class Person extends Equatable {
  final String modelId;
  final String name;
  final int age;
  final Gender gender;
  final String job;
  final String bio;
  final String lifeStyle;
  final List<String> interests;
  final String requestToChat;
  final List<String> photos;
  final String video;
  final String avatarMini;
  final String avatar;
  final bool sfw;

  const Person({
    required this.modelId,
    required this.name,
    required this.age,
    required this.gender,
    required this.bio,
    required this.job,
    required this.sfw,
    this.lifeStyle = '',
    this.video = '',
    this.avatarMini = '',
    this.avatar = '',
    this.photos = const [],
    this.interests = const [],
    required this.requestToChat,
  });

  Person copyWith({
    String? modelId,
    String? name,
    int? age,
    Gender? gender,
    String? job,
    String? bio,
    String? lifeStyle,
    String? video,
    String? avatarMini,
    String? avatar,
    List<String>? interests,
    List<String>? photos,
    String? requestToChat,
    bool? sfw,
  }) {
    return Person(
      age: age ?? this.age,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      job: job ?? this.job,
      modelId: modelId ?? this.modelId,
      name: name ?? this.name,
      requestToChat: requestToChat ?? this.requestToChat,
      interests: interests ?? this.interests,
      lifeStyle: lifeStyle ?? this.lifeStyle,
      photos: photos ?? this.photos,
      sfw: sfw ?? this.sfw,
      video: video ?? this.video,
      avatarMini: avatarMini ?? this.avatarMini,
      avatar: avatar ?? this.avatar,
    );
  }

  static Person fromJson(Map<String, dynamic> json) {
    Gender getGender(String name) {
      if (name == LocaleKeys.properties_genders_male1.tr()) {
        return Gender.male;
      }
      if (name == LocaleKeys.properties_genders_female1.tr()) {
        return Gender.female;
      }
      if (name == LocaleKeys.properties_genders_nonBinary.tr()) {
        return Gender.nonBinary;
      }

      return Gender.none;
    }

    var person = Person(
      modelId: json['modelId'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? '',
      bio: json['bio'] ?? '',
      job: json['job'] ?? '',
      sfw: json['boundaries.store_sfw'] ?? true,
      requestToChat: json['requestToChat'] ?? '',
      lifeStyle: json['lifeStyle'] ?? '',
      video: json['video'] ?? '',
      avatarMini: json['avatarMini'] ?? '',
      avatar: json['avatar'] ?? '',
      gender: getGender(json['gender'] ?? ''),
      interests: json['interests'] != null
          ? (json['interests'] as List<dynamic>)
                .map((e) => e as String)
                .toList()
          : const <String>[],
      photos: json['photos'] != null
          ? (json['photos'] as List<dynamic>).map((e) => e as String).toList()
          : const <String>[],
    );

    return person;
  }

  String toJson() {
    Map<String, dynamic> jsonMap = {
      'modelId': modelId,
      'name': name,
      'age': age,
      'bio': bio,
      'job': job,
      'requestToChat': requestToChat,
      'lifeStyle': lifeStyle,
      'gender': gender.getGenderForInterestedName(),
      'interests': interests,
      'photos': photos,
      'boundaries.store_sfw': sfw,
      'avatarMini': avatarMini,
      'avatar': avatar,
      'video': video,
    };

    return json.encode(jsonMap);
  }

  @override
  List<Object?> get props => [
    modelId,
    name,
    age,
    gender,
    job,
    bio,
    lifeStyle,
    interests,
    requestToChat,
    photos,
    sfw,
    video,
    avatarMini,
    avatar,
  ];
}
