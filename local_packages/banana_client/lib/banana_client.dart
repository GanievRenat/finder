import 'dart:typed_data';

import 'package:banana_client/banana_client.dart';
import 'package:banana_client/common/config/app_config.dart';
import 'package:banana_client/common/data/api/generate_image/generate_image_api.dart';
import 'package:banana_client/common/data/repository/banana_repository.dart';
import 'package:banana_client/common/data/source/network/interceptors/interceptors.dart';
import 'package:banana_client/common/data/source/network/network_manager.dart';
import 'package:banana_client/common/domain/app_config.dart';
import 'package:banana_client/common/domain/usecases/generate_image_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

export 'common/domain/entities/answer/answer.dart';

class BananaClient {
  BananaClient()
    : _bananaConfig = DefBananaConfig(),
      _connectionChecker = InternetConnectionChecker.instance,
      _logger = Logger();

  final AppConfig _bananaConfig;
  final InternetConnectionChecker _connectionChecker;
  final Logger _logger;
  late GenerateImage generateImage;
  bool initKey = false;

  void setKey({required String key}) {
    init(key);
  }

  void init(String key) {
    generateImage = GenerateImage(
      bananaRepository: BananaRepositoryImpl(
        logger: _logger,
        generateImageApi: GenerateImageApi(
          NetworkManager.getApiDioClient(
            config: _bananaConfig,
            errorInterceptor: ErrorInterceptor(
              connectionChecker: _connectionChecker,
            ),
            loggerInterceptor: LoggerInterceptor(logger: _logger),
            tokenInterceptor: TokenInterceptor(key: key),
          ),
        ),
      ),
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
}
