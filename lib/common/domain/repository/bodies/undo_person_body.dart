import 'body_request.dart';

class UndoLastBody extends RequestBody {
  final String _userUid;

  UndoLastBody({required String userUid}) : _userUid = userUid;

  String get userUid => _userUid;

  @override
  Map<String, dynamic> toMap() {
    return {"userUid": _userUid};
  }
}
