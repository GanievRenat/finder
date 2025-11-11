import '../../bodies/body_request.dart';

class AuthByAdminBody extends RequestBody {
  final String email;
  final String password;

  AuthByAdminBody({required this.email, required this.password});

  @override
  Map<String, dynamic> toMap() {
    return {"email": email, "password": password};
  }
}
