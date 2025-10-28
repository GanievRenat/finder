import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/enums.dart';

class User extends Equatable {
  final String name;
  final int age;
  final Gender? gender;
  final UserTypeRegistrationEnums typeRegistration;
  final bool isSaveed;
  final String uid;
  final bool isPremium;

  const User({
    required this.name,
    required this.age,
    this.gender,
    this.isSaveed = false,
    this.isPremium = false,
    this.typeRegistration = UserTypeRegistrationEnums.guest,
    this.uid = '',
  });

  const User.empty()
    : name = '',
      age = 0,
      gender = null,
      isSaveed = false,
      isPremium = false,
      uid = '',
      typeRegistration = UserTypeRegistrationEnums.guest;

  User copyWith({
    String? name,
    int? age,
    Gender? gender,
    UserTypeRegistrationEnums? typeRegistration,
    bool? isSaveed,
    bool? isPremium,
    String? uid,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      typeRegistration: typeRegistration ?? this.typeRegistration,
      isSaveed: isSaveed ?? this.isSaveed,
      isPremium: isPremium ?? this.isPremium,
      uid: uid ?? this.uid,
    );
  }

  @override
  List<Object?> get props => [
    name,
    age,
    gender,
    uid,
    isPremium,
    typeRegistration,
  ];
}
