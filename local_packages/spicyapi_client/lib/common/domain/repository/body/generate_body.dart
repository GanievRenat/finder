import 'body_request.dart';

class GenerateBody extends RequestBody {
  final String refBase64Data;
  final String prompt;
  final String clientId;
  final String apiKey;
  final String negativePrompt;

  GenerateBody({
    required this.refBase64Data,
    required this.prompt,
    required this.negativePrompt,
    required this.clientId,
    required this.apiKey,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "prompt": prompt,
      "negative_prompt": negativePrompt,
      "base64Image": refBase64Data,
      "client_id": clientId,
      "api_key": apiKey,
      "seed": null,
      "has_anime": false,
    };
  }
}
