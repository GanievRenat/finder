import 'package:either_dart/either.dart';

import '../entities/answer/answer.dart';
import 'body/send_message_body.dart';

abstract class MessageRepository {
  Future<Either<SendMessageError, Answer>> send(SendMessageBody body);
}

enum SendMessageError { wrongSomeThings, noInternetConnection }
