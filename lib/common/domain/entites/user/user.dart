import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/gender_enums.dart';

class User extends Equatable {
  final String name;
  final int age;
  final Gender? gender;
  final bool isSaveed;
  final String uid;

  const User({
    required this.name,
    required this.age,
    this.gender,
    this.isSaveed = false,
    this.uid = '',
  });

  const User.empty()
    : name = '',
      age = 0,
      gender = null,
      isSaveed = false,
      uid = '';

  User copyWith({
    String? name,
    int? age,
    Gender? gender,
    bool? isSaveed,
    String? uid,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      isSaveed: isSaveed ?? this.isSaveed,
      uid: uid ?? this.uid,
    );
  }

  @override
  List<Object?> get props => [name, age, gender, uid];
}
