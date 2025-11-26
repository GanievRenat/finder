import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/generated/locale_keys.g.dart';

abstract class ChatRepository {
  Future<Either<ChatError, int>> createNewChat(CreateNewChatBody body);
  // Получить чаты пользователя
  Future<Either<ChatError, List<Chat>>> getChats(String userId);
  // Получить все сообщения конкретного чата
  Future<Either<ChatError, List<Messages>>> getMessageOfChat(
    GetMessageOfChatBody body,
  );
  // Добавить новое сообщение в чат
  Future<Either<ChatError, List<Messages>>> addNewMessage(
    String userUid,
    AddNewMessageBody body,
  );
  // Подготовить промт для отправки нового сообщения
}

sealed class ChatError {
  final String errorText;
  ChatError(this.errorText);
}

class MainChatError extends ChatError {
  MainChatError() : super(LocaleKeys.filter_errors_main.tr());
}
