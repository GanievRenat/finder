import 'package:firebase_auth/firebase_auth.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';

class AuthInitAdminService {
  final InitAdmin initAdmin;
  final Function(User user) auth;
  final Function() noAuth;

  AuthInitAdminService({
    required this.initAdmin,
    required this.auth,
    required this.noAuth,
  }) {
    _initAuth();
  }

  void _initAuth() async {
    var result = await initAdmin();
    if (result != null) {
      auth(result);
    } else {
      noAuth();
    }
  }
}
