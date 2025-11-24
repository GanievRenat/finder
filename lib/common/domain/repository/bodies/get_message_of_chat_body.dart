import 'body_request.dart';

class GetMessageOfChatBody extends RequestBody {
  final String modelId;
  final String userUid;

  GetMessageOfChatBody({required this.modelId, required this.userUid});

  @override
  Map<String, dynamic> toMap() {
    return {"modelId": modelId, "userUid": userUid};
  }
}
