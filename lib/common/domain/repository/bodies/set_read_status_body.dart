import 'body_request.dart';

class SetReadStatusBody extends RequestBody {
  final String modelId;
  final String userUid;

  SetReadStatusBody({required this.modelId, required this.userUid});

  @override
  Map<String, dynamic> toMap() {
    return {"modelId": modelId, "userUid": userUid};
  }
}
