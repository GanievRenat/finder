import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_data_model.freezed.dart';
part 'registration_data_model.g.dart';

@freezed
abstract class RegistrationDataModel with _$RegistrationDataModel {
  const factory RegistrationDataModel({
    required String name,
    required int age,
    int? gender,
    int? interestedGender,
  }) = _RegistrationDataModel;

  factory RegistrationDataModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationDataModelFromJson(json);
}

extension RegistrationDataModelToEntites on RegistrationDataModel {
  RegistrationData toEntites() {
    return RegistrationData(
      name: name,
      age: age,
      gender: gender != null ? Gender.values[gender!] : null,
      interestedGender: interestedGender != null
          ? Gender.values[interestedGender!]
          : null,
    );
  }
}
