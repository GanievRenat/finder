import 'package:flirta/common/enums/enums.dart';

import 'body_request.dart';

class RegistrationDataBody extends RequestBody {
  final String name;
  final int age;
  final Gender? gender;
  final Gender? interestedGender;

  RegistrationDataBody({
    this.name = '',
    this.age = 25,
    this.gender = Gender.none,
    this.interestedGender = Gender.none,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender?.index,
      'interestedGender': interestedGender?.index,
    };
  }
}
