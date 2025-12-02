import 'package:deepseek_client/common/domain/entities/message/message.dart';
import 'package:equatable/equatable.dart';

class Choice extends Equatable {
  final int index;
  final Message? message;
  final String finishReason;

  const Choice({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  @override
  List<Object?> get props => [index, message, finishReason];
}
