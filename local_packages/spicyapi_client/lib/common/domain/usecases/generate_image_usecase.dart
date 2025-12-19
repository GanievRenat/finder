import 'dart:convert';
import 'dart:typed_data';

import 'package:either_dart/either.dart';
import '../entities/answer/answer.dart';
import '../repository/body/generate_body.dart';
import '../repository/spacyapi_repository.dart';

class GenerateImage {
  final SpacyAPIRepository _bananaRepository;
  final String _apiKey;
  final String _clientId;
  final String _negativePrompt;

  GenerateImage({
    required SpacyAPIRepository repository,
    required String apiKey,
    required String clientId,
    required String negativePrompt,
  }) : _bananaRepository = repository,
       _apiKey = apiKey,
       _clientId = clientId,
       _negativePrompt = negativePrompt;

  Future<Either<SendMessageError, Answer>> call({
    required String prompt,
    required Uint8List refData,
  }) async {
    var result = await _bananaRepository.generate(
      GenerateBody(
        prompt: prompt,
        refBase64Data: base64.encode(refData),
        apiKey: _apiKey,
        clientId: _clientId,
        negativePrompt: _negativePrompt,
      ),
    );
    return result;
  }
}
