import 'package:spicyapi_client/common/data/api/check_status/body/check_status_model.dart';
import 'package:spicyapi_client/common/data/api/check_status/check_status_api.dart';

import '../../domain/repository/body/check_status_body.dart';

import '../../data/api/generate_image/body/request_model.dart';
import '../../domain/entities/answer/answer.dart';
import '../../domain/repository/body/generate_body.dart';
import '../../domain/repository/spacyapi_repository.dart';
import 'package:either_dart/either.dart';
import 'package:logger/logger.dart';

import '../api/generate_image/generate_image_api.dart';
import '../models/answer/answer_model.dart';

class SpacyAPIRepositoryImpl implements SpacyAPIRepository {
  final GenerateImageApi _generateImageApi;
  final CheckStatusApi _checkStatusApi;
  final Logger _logger;

  SpacyAPIRepositoryImpl({
    required GenerateImageApi generateImageApi,
    required CheckStatusApi checkStatusApi,
    required Logger logger,
  }) : _generateImageApi = generateImageApi,
       _checkStatusApi = checkStatusApi,
       _logger = logger;

  @override
  Future<Either<SendMessageError, Answer>> generate(GenerateBody body) async {
    try {
      var request = RequestModel(
        prompt: body.prompt,
        base64Image: body.refBase64Data,
        apiKey: body.apiKey,
        clientId: body.clientId,
        hasAnime: false,
        negativePrompt: body.negativePrompt,
      );
      var result = await _generateImageApi.send(request: request);
      _logger.d(result.toString());
      return Right(result.toEntites());
    } catch (e) {
      _logger.e(e.toString());
      return Left(SendMessageError.wrongSomeThings);
    }
  }

  @override
  Future<Either<SendMessageError, Answer>> checkStatus(
    CheckStatusBody body,
  ) async {
    try {
      var request = CheckStatusModel(
        apiKey: body.apiKey,
        clientId: body.clientId,
        requestId: body.requestId,
      );
      var result = await _checkStatusApi.send(request: request);
      _logger.d(result.toString());
      return Right(result.toEntites());
    } catch (e) {
      _logger.e(e.toString());
      return Left(SendMessageError.wrongSomeThings);
    }
  }
}
