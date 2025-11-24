import 'package:flirta/common/enums/enums.dart';

import 'body_request.dart';

class AddNewMessageBody extends RequestBody {
  final String modelId;
  final Owner owner;
  final String message;
  final List<String> images;

  AddNewMessageBody({
    required this.modelId,
    required this.owner,
    required this.message,
    required this.images,
  });

  @override
  Map<String, dynamic> toMap() {
    return {"modelId": modelId};
  }
}
