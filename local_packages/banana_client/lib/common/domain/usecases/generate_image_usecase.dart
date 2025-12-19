import 'dart:convert';
import 'dart:typed_data';

import 'package:either_dart/either.dart';
import '../entities/answer/answer.dart';
import '../repository/body/generate_body.dart';
import '../repository/banana_repository.dart';

class GenerateImage {
  final BananaRepository _bananaRepository;

  GenerateImage({required BananaRepository bananaRepository})
    : _bananaRepository = bananaRepository;

  Future<Either<SendMessageError, Answer>> call({
    required String prompt,
    required Uint8List refData,
  }) async {
    var result = await _bananaRepository.generate(
      GenerateBody(prompt: prompt, refBase64Data: base64.encode(refData)),
    );
    return result;
  }
}
