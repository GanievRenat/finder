import 'body_request.dart';

class GenerateBody extends RequestBody {
  final String refBase64Data;
  final String prompt;

  GenerateBody({required this.refBase64Data, required this.prompt});

  @override
  Map<String, dynamic> toJson() {
    return {
      "contents": [
        {
          "parts": [
            {"text": prompt},
            {
              "inline_data": {"mime_type": "image/png", "data": refBase64Data},
            },
          ],
        },
      ],
      "generationConfig": {"temperature": 0.4, "topP": 0.9, "topK": 40},
    };
  }
}
