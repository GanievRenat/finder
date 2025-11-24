import 'body_request.dart';

class CreateNewChatBody extends RequestBody {
  final String modelId;
  final String modelName;
  final String modelAvatar;
  final String userUid;

  CreateNewChatBody({
    required this.modelId,
    required this.userUid,
    required this.modelName,
    required this.modelAvatar,
  });

  @override
  Map<String, dynamic> toMap() {
    return {"modelId": modelId, "userUid": userUid};
  }
}
