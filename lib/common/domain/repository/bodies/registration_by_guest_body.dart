import 'package:flirta/common/enums/enums.dart';

import 'body_request.dart';

class RegistrationByGuestBody extends RequestBody {
  final String name;
  final int age;
  final Gender gender;

  RegistrationByGuestBody({
    required this.name,
    required this.age,
    required this.gender,
  });

  @override
  Map<String, dynamic> toMap() {
    return {"name": name, "age": age, "gender": gender.index};
  }
}
