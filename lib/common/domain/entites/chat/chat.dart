import 'package:equatable/equatable.dart';

import 'message.dart';

class Chat extends Equatable {
  final String modelId;
  final String modelName;
  final String modelAvatar;
  final DateTime atCreated;
  final int countNewMessage;
  final String lastMessage;
  final List<Messages> messages;

  const Chat({
    required this.modelId,
    required this.modelName,
    required this.modelAvatar,
    required this.atCreated,
    required this.countNewMessage,
    required this.lastMessage,
    required this.messages,
  });

  Chat copyWith({
    String? modelId,
    String? modelName,
    String? modelAvatar,
    DateTime? atCreated,
    int? countNewMessage,
    String? lastMessage,
    List<Messages>? messages,
  }) {
    return Chat(
      modelId: modelId ?? this.modelId,
      modelName: modelName ?? this.modelName,
      modelAvatar: modelAvatar ?? this.modelAvatar,
      atCreated: atCreated ?? this.atCreated,
      countNewMessage: countNewMessage ?? this.countNewMessage,
      lastMessage: lastMessage ?? this.lastMessage,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [
    modelId,
    modelName,
    modelAvatar,
    atCreated,
    countNewMessage,
    lastMessage,
    messages,
  ];
}
