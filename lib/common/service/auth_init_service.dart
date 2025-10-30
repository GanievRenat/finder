import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';

class AuthInitService {
  final GetProfile getProfile;
  final Function(User user) auth;
  final Function() noAuth;

  AuthInitService({
    required this.getProfile,
    required this.auth,
    required this.noAuth,
  }) {
    _initAuth();
  }

  void _initAuth() async {
    var result = await getProfile();
    if (result.isRight) {
      auth(result.right);
    } else {
      noAuth();
    }
  }
}
