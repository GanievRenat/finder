import 'body_request.dart';

class GetDetailOfPersonBody extends RequestBody {
  final String _modelId;

  GetDetailOfPersonBody({required String modelId}) : _modelId = modelId;

  String get modelId => _modelId;

  @override
  Map<String, dynamic> toMap() {
    return {"modelId": _modelId};
  }
}
