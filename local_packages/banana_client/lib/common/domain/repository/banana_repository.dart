import 'package:either_dart/either.dart';

import '../entities/answer/answer.dart';
import 'body/generate_body.dart';

abstract class BananaRepository {
  Future<Either<SendMessageError, Answer>> generate(GenerateBody body);
}

enum SendMessageError { wrongSomeThings, noInternetConnection }
