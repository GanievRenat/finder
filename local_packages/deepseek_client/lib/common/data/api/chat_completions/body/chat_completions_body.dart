import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_completions_body.freezed.dart';
part 'chat_completions_body.g.dart';

@freezed
abstract class ChatCompletionsBody with _$ChatCompletionsBody {
  const factory ChatCompletionsBody({
    required List<Map<String, dynamic>> messages,
    required String model,
    @JsonKey(name: 'frequency_penalty') required int frequencyPenalty,
  }) = _ChatCompletionsBody;

  factory ChatCompletionsBody.fromJson(Map<String, Object?> json) =>
      _$ChatCompletionsBodyFromJson(json);
}
