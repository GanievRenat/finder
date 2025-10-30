import 'package:flirta/common/enums/enums.dart';

import 'body_request.dart';

class UpdateUserBody extends RequestBody {
  final String name;
  final String photo;
  final int age;
  final Gender? gender;

  UpdateUserBody({
    this.name = '',
    this.age = 25,
    this.gender = Gender.none,
    this.photo = '',
  });

  @override
  Map<String, dynamic> toMap() {
    return {'name': name, 'age': age, 'gender': gender?.index, 'photo': photo};
  }
}
