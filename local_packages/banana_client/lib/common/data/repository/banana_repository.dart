import 'package:banana_client/common/data/api/generate_image/body/candidates/content/content_model.dart';
import 'package:banana_client/common/data/api/generate_image/body/candidates/content/parts/inline_data/inline_data_model.dart';
import 'package:banana_client/common/data/api/generate_image/body/candidates/content/parts/parts_model.dart';
import 'package:banana_client/common/data/api/generate_image/body/request_model.dart';
import 'package:banana_client/common/data/models/answer/answer_model.dart';
import 'package:banana_client/common/domain/entities/answer/answer.dart';
import 'package:banana_client/common/domain/repository/body/generate_body.dart';
import 'package:banana_client/common/domain/repository/banana_repository.dart';
import 'package:either_dart/either.dart';
import 'package:logger/logger.dart';

import '../api/generate_image/generate_image_api.dart';

class BananaRepositoryImpl implements BananaRepository {
  final GenerateImageApi _generateImageApi;
  final Logger _logger;

  BananaRepositoryImpl({
    required GenerateImageApi generateImageApi,
    required Logger logger,
  }) : _generateImageApi = generateImageApi,
       _logger = logger;

  @override
  Future<Either<SendMessageError, Answer>> generate(GenerateBody body) async {
    try {
      var request = RequestModel(
        contents: [
          ContentModel(
            parts: [
              PartsModel(text: body.prompt),
              PartsModel(
                inlineData: InlineDataModel(
                  mimeType: 'image/jpeg',
                  data: body.refBase64Data,
                ),
              ),
            ],
          ),
        ],
      );
      var result = await _generateImageApi.send(request: request);
      _logger.d(result.toString());
      return Right(result.toEntites());
    } catch (e) {
      _logger.e(e.toString());
      return Left(SendMessageError.wrongSomeThings);
    }
  }
}
