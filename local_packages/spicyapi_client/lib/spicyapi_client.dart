import 'dart:typed_data';

import 'package:spicyapi_client/common/data/api/check_status/check_status_api.dart';

import 'common/domain/usecases/check_status_usecase.dart';
import 'spicyapi_client.dart';
import 'common/config/app_config.dart';
import 'common/data/api/generate_image/generate_image_api.dart';
import 'common/data/repository/spacyapi_repository.dart';
import 'common/data/source/network/interceptors/interceptors.dart';
import 'common/data/source/network/network_manager.dart';
import 'common/domain/app_config.dart';
import 'common/domain/usecases/generate_image_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

export 'common/domain/entities/answer/answer.dart';

class SpacyAPIClient {
  SpacyAPIClient()
    : _config = DefSpacyAPIConfig(),
      _connectionChecker = InternetConnectionChecker.instance,
      _logger = Logger();

  final AppConfig _config;
  final InternetConnectionChecker _connectionChecker;
  final Logger _logger;
  late GenerateImage generateImage;
  late CheckStatus checkStatus;
  bool initKey = false;

  void setKey({
    required String key,
    required String clientId,
    required String negativePrompt,
  }) {
    init(key: key, clientId: clientId, negativePrompt: negativePrompt);
  }

  void init({
    required String key,
    required String clientId,
    required String negativePrompt,
  }) {
    var dioClient = NetworkManager.getApiDioClient(
      config: _config,
      errorInterceptor: ErrorInterceptor(connectionChecker: _connectionChecker),
      loggerInterceptor: LoggerInterceptor(logger: _logger),
      tokenInterceptor: TokenInterceptor(key: key),
    );

    var repository = SpacyAPIRepositoryImpl(
      logger: _logger,
      generateImageApi: GenerateImageApi(dioClient),
      checkStatusApi: CheckStatusApi(dioClient),
    );

    generateImage = GenerateImage(
      repository: repository,
      apiKey: key,
      clientId: clientId,
      negativePrompt: negativePrompt,
    );
    checkStatus = CheckStatus(
      repository: repository,
      apiKey: key,
      clientId: clientId,
    );
    initKey = true;
  }

  Future<Answer?> generate({
    required String prompt,
    required Uint8List refData,
  }) async {
    if (initKey) {
      var result = await generateImage(prompt: prompt, refData: refData);
      if (result.isRight) {
        return result.right;
      }
    }
    return null;
  }

  Future<Answer?> getStatus({required String requestId}) async {
    if (initKey) {
      var result = await checkStatus(requestId: requestId);
      if (result.isRight) {
        return result.right;
      }
    }
    return null;
  }
}
