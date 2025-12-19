import 'body_request.dart';

class CheckStatusBody extends RequestBody {
  final String requestId;
  final String clientId;
  final String apiKey;

  CheckStatusBody({
    required this.requestId,
    required this.clientId,
    required this.apiKey,
  });

  @override
  Map<String, dynamic> toJson() {
    return {"request_id": requestId, "client_id": clientId, "api_key": apiKey};
  }
}
