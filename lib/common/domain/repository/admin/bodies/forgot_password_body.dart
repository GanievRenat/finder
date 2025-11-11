import '../../bodies/body_request.dart';

class ForgotPasswordBody extends RequestBody {
  final String email;

  ForgotPasswordBody({required this.email});

  @override
  Map<String, dynamic> toMap() {
    return {"email": email};
  }
}
