import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/auth_repository.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/enums/enums.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'registration_state.dart';
part 'registration_cubit.freezed.dart';

@singleton
class RegistrationCubit extends Cubit<RegistrationState> {
  final SaveRegistrationFormData _saveRegistrationData;
  final LoadRegistrationFormData _loadRegistrationData;
  final ClearRegistrationFormData _clearRegistrationData;
  final RegistrationNewUserByGuest _registrationNewUserByGuest;

  RegistrationData currentData = RegistrationData.empty();

  RegistrationCubit({
    required SaveRegistrationFormData saveRegistrationData,
    required LoadRegistrationFormData loadRegistrationData,
    required ClearRegistrationFormData clearRegistrationData,
    required RegistrationNewUserByGuest registrationNewUserByGuest,
  }) : _saveRegistrationData = saveRegistrationData,
       _loadRegistrationData = loadRegistrationData,
       _clearRegistrationData = clearRegistrationData,
       _registrationNewUserByGuest = registrationNewUserByGuest,
       super(RegistrationState.init()) {
    getCurrentData();
  }

  Future<void> getCurrentData() async {
    emit(RegistrationState.loading());
    currentData = await _loadRegistrationData();
    emit(RegistrationState.data(currentData));
  }

  Future<void> saveCurrentState() async {
    await _saveRegistrationData(
      RegistrationDataBody(
        age: currentData.age,
        name: currentData.name,
        gender: currentData.gender,
        interestedGender: currentData.interestedGender,
      ),
    );
  }

  Future<Either<AuthRepositoryErrors, bool>> registrationByGuest() async {
    var result = await _registrationNewUserByGuest.call(
      RegistrationByGuestBody(
        name: currentData.name,
        age: currentData.age,
        gender: currentData.gender!,
      ),
    );
    return result;
  }

  Future<void> clearCurrentData() async {
    await _clearRegistrationData();
    currentData = RegistrationData.empty();
    emit(RegistrationState.data(currentData));
  }

  void setName(String name) async {
    currentData = currentData.copyWith(name: name);
  }

  void setAge(int age) async {
    currentData = currentData.copyWith(age: age);
  }

  void setGender(Gender gender) async {
    currentData = currentData.copyWith(gender: gender);
  }

  void setIntrestedGender(Gender gender) async {
    currentData = currentData.copyWith(interestedGender: gender);
  }
}
