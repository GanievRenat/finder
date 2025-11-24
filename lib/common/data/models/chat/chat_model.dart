import 'package:flirta/common/domain/entites/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel with _$ChatModel {
  const factory ChatModel({
    @Default(0) int atCreated,
    @Default('') String userUid,
    @Default('') String modelId,
    @Default('') String modelName,
    @Default('') String modelAvatar,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json) =>
      _$ChatModelFromJson(json);
}

extension ChatModelToEntites on ChatModel {
  Chat toEntites(List<Messages> messages) {
    return Chat(
      atCreated: DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch),
      modelAvatar: modelAvatar,
      modelId: modelId,
      modelName: modelName,
      messages: messages,
      lastMessage: messages.last,
      countNewMessage: messages.where((msg) => !msg.isRead).length,
    );
  }
}
