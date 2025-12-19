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
  final bool waitingAnswer;
  final bool waitingPhoto;
  final int lastUpdate;

  const Chat({
    required this.modelId,
    required this.modelName,
    required this.modelAvatar,
    required this.atCreated,
    required this.countNewMessage,
    required this.lastMessage,
    required this.messages,
    required this.waitingAnswer,
    required this.waitingPhoto,
    required this.lastUpdate,
  });

  Chat copyWith({
    String? modelId,
    String? modelName,
    String? modelAvatar,
    DateTime? atCreated,
    int? countNewMessage,
    String? lastMessage,
    List<Messages>? messages,
    bool? waitingAnswer,
    bool? waitingPhoto,
    int? lastUpdate,
  }) {
    return Chat(
      modelId: modelId ?? this.modelId,
      modelName: modelName ?? this.modelName,
      modelAvatar: modelAvatar ?? this.modelAvatar,
      atCreated: atCreated ?? this.atCreated,
      countNewMessage: countNewMessage ?? this.countNewMessage,
      lastMessage: lastMessage ?? this.lastMessage,
      messages: messages ?? this.messages,
      waitingAnswer: waitingAnswer ?? this.waitingAnswer,
      waitingPhoto: waitingPhoto ?? this.waitingPhoto,
      lastUpdate: lastUpdate ?? this.lastUpdate,
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
    waitingAnswer,
    waitingPhoto,
    lastUpdate,
  ];
}
