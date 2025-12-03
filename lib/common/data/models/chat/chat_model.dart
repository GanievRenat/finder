import 'package:flirta/common/domain/entites/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel with _$ChatModel {
  const factory ChatModel({
    @Default(0) @JsonKey(name: 'atCreated') int atCreated,
    @Default('') @JsonKey(name: 'userUid') String userUid,
    @Default('') @JsonKey(name: 'modelId') String modelId,
    @Default('') @JsonKey(name: 'modelName') modelName,
    @Default('') @JsonKey(name: 'modelAvatar') modelAvatar,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json) =>
      _$ChatModelFromJson(json);
}

extension ChatModelToEntites on ChatModel {
  Chat toEntites(List<Messages> messages) {
    return Chat(
      atCreated: DateTime.fromMillisecondsSinceEpoch(atCreated),
      modelAvatar: modelAvatar,
      modelId: modelId,
      modelName: modelName,
      messages: messages,
      lastMessage: (messages.isNotEmpty) ? messages.last.message : '',
      lastUpdate: (messages.isNotEmpty)
          ? messages.last.atCreated.millisecondsSinceEpoch
          : 0,
      countNewMessage: messages.where((msg) => !msg.isRead).length,
      waitingAnswer: false,
    );
  }
}
