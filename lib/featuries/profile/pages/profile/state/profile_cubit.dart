import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/featuries/registration/state/registration_cubit.dart';
import 'package:flirta/generated/locale_keys.g.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

@singleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required GetProfile getProfileGuest,
    required DeleteProfile deleteProfile,
    required RegistrationCubit registrationCubit,
  }) : _getProfileGuest = getProfileGuest,
       _deleteProfile = deleteProfile,
       _registrationCubit = registrationCubit,
       super(ProfileState.init());

  final GetProfile _getProfileGuest;
  final DeleteProfile _deleteProfile;
  final RegistrationCubit _registrationCubit;

  void init() async {
    emit(ProfileState.loading());
    final userCurrent = await _getProfileGuest();
    if (userCurrent.isRight) {
      emit(ProfileState.data(userCurrent.right));
    } else {
      emit(ProfileState.error(LocaleKeys.user_profile_error_get_profile_error));
    }
  }

  Future<Either<ProfileRepositoryError, bool>> deleteProfile() async {
    var result = await _deleteProfile();
    if (result.isRight) {
      await _registrationCubit.clearCurrentData();
    }

    return result;
  }
}
