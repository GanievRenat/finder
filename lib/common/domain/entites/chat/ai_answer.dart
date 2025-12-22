import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/enums.dart';

class AIAnswer extends Equatable {
  final AIAgentResultAnswer result;
  final String message;
  final String requestForImageGeneration;
  final AIAgentChat messageAiAgent;
  final List<String> images;
  final AIAgentImage imageAiAgent;

  const AIAnswer({
    required this.message,
    required this.messageAiAgent,
    this.images = const [],
    this.imageAiAgent = AIAgentImage.none,
    this.requestForImageGeneration = '',
  }) : result = AIAgentResultAnswer.success;

  const AIAnswer.error()
    : result = AIAgentResultAnswer.error,
      images = const [],
      imageAiAgent = AIAgentImage.none,
      message = '',
      requestForImageGeneration = '',
      messageAiAgent = AIAgentChat.none;

  @override
  List<Object?> get props => [
    result,
    message,
    requestForImageGeneration,
    images,
    messageAiAgent,
    imageAiAgent,
  ];
}
