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

  const Person({
    required this.modelId,
    required this.name,
    required this.age,
    required this.gender,
    required this.bio,
    required this.job,
    this.lifeStyle = '',
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
    List<String>? interests,
    List<String>? photos,
    String? requestToChat,
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
      requestToChat: json['requestToChat'] ?? '',
      lifeStyle: json['lifeStyle'] ?? '',
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
  ];
}
