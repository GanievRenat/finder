import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/enums.dart';

class User extends Equatable {
  final String name;
  final int age;
  final Gender? gender;
  final UserTypeRegistrationEnums typeRegistration;
  final String uid;
  final String photo;

  const User({
    required this.name,
    required this.age,
    this.gender,
    this.typeRegistration = UserTypeRegistrationEnums.guest,
    this.uid = '',
    this.photo = '',
  });

  const User.empty()
    : name = '',
      age = 0,
      gender = null,
      uid = '',
      typeRegistration = UserTypeRegistrationEnums.guest,
      photo = '';

  User copyWith({
    String? name,
    int? age,
    Gender? gender,
    UserTypeRegistrationEnums? typeRegistration,
    String? uid,
    String? photo,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      photo: photo ?? this.photo,
      gender: gender ?? this.gender,
      typeRegistration: typeRegistration ?? this.typeRegistration,
      uid: uid ?? this.uid,
    );
  }

  @override
  List<Object?> get props => [name, age, gender, uid, typeRegistration, photo];
}
