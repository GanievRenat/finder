import 'package:flirta/common/domain/entites/entities.dart';

import 'body_request.dart';

class UndoPersonBody extends RequestBody {
  final Person _person;
  final String _userUid;

  UndoPersonBody({required Person person, required String userUid})
    : _person = person,
      _userUid = userUid;

  Person get person => _person;
  String get userUid => _userUid;

  @override
  Map<String, dynamic> toMap() {
    return {"modelId": _person.modelId, "userUid": _userUid};
  }
}
