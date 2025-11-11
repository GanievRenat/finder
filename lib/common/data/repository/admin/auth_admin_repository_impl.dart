import 'package:firebase_auth/firebase_auth.dart';
import 'package:flirta/common/domain/repository/admin/bodies/auth_by_admin_body.dart';
import 'package:flirta/common/domain/repository/admin/bodies/forgot_password_body.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

import '../../providers/admin/auth_admin_data_provider.dart';

@Singleton(as: AuthAdminRepository)
class AuthAdminRepositoryImpl implements AuthAdminRepository {
  final AuthAdminDataProvider _dataProvider;

  AuthAdminRepositoryImpl({
    required AuthAdminDataProvider dataProvider,
    required AppStateService appStateService,
  }) : _dataProvider = dataProvider;

  @override
  Future<User?> init() async {
    var user = await _dataProvider.init();
    return user;
  }

  @override
  Future<Either<AuthAdminRepositoryErrors, User>> authByAdmin(
    AuthByAdminBody body,
  ) async {
    var result = await _dataProvider.authByAdmin(body);
    return result;
  }

  @override
  Future<Either<AuthAdminRepositoryErrors, bool>> forgotPassword(
    ForgotPasswordBody body,
  ) async {
    var result = await _dataProvider.forgotPassword(body);
    return result;
  }

  @override
  Future<Either<AuthAdminRepositoryErrors, bool>> logout() async {
    var result = await _dataProvider.logout();
    return result;
  }
}
