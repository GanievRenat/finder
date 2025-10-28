import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/enums.dart';

class RegistrationData extends Equatable {
  final String name;
  final int age;
  final Gender? gender;
  final Gender? interestedGender;

  const RegistrationData({
    required this.name,
    required this.age,
    this.gender,
    this.interestedGender,
  });

  const RegistrationData.empty()
    : name = '',
      age = 25,
      gender = null,
      interestedGender = null;

  RegistrationData copyWith({
    String? name,
    int? age,
    Gender? gender,
    Gender? interestedGender,
  }) {
    return RegistrationData(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      interestedGender: interestedGender ?? this.interestedGender,
    );
  }

  @override
  List<Object?> get props => [name, age, gender, interestedGender];
}
