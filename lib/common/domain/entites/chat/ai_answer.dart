import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/enums.dart';

class AIAnswer extends Equatable {
  final AIAgentResultAnswer result;
  final String message;
  final AIAgentChat messageAiAgent;
  final List<String> images;
  final AIAgentImage imageAiAgent;

  const AIAnswer({
    required this.message,
    required this.messageAiAgent,
    this.images = const [],
    this.imageAiAgent = AIAgentImage.none,
  }) : result = AIAgentResultAnswer.success;

  const AIAnswer.error()
    : result = AIAgentResultAnswer.error,
      images = const [],
      imageAiAgent = AIAgentImage.none,
      message = '',
      messageAiAgent = AIAgentChat.none;

  @override
  List<Object?> get props => [
    result,
    message,
    images,
    messageAiAgent,
    imageAiAgent,
  ];
}
