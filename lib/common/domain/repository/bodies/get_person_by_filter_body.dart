import 'body_request.dart';

class GetPersonByFilterBody extends RequestBody {
  final String modelId;
  final int limit;
  final String gender;

  GetPersonByFilterBody({this.modelId = '', this.gender = '', this.limit = 20});

  @override
  Map<String, dynamic> toMap() {
    return {"modelId": modelId, "limit": limit, "gender": gender};
  }
}
