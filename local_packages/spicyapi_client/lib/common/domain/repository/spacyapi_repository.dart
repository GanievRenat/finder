import 'package:either_dart/either.dart';
import 'package:spicyapi_client/common/domain/repository/body/check_status_body.dart';

import '../entities/answer/answer.dart';
import 'body/generate_body.dart';

abstract class SpacyAPIRepository {
  Future<Either<SendMessageError, Answer>> generate(GenerateBody body);
  Future<Either<SendMessageError, Answer>> checkStatus(CheckStatusBody body);
}

enum SendMessageError { wrongSomeThings, noInternetConnection }
