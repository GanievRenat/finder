import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_completions_body.freezed.dart';
part 'chat_completions_body.g.dart';

@freezed
abstract class ChatCompletionsBody with _$ChatCompletionsBody {
  const factory ChatCompletionsBody({
    @Default([]) @JsonKey(name: 'messages') List<Map<String, dynamic>> messages,
    @Default('venice-uncensored') @JsonKey(name: 'model') String model,
    @Default({})
    @JsonKey(name: 'venice_parameters')
    Map<String, dynamic> veniceParameters,
  }) = _ChatCompletionsBody;

  factory ChatCompletionsBody.fromJson(Map<String, Object?> json) =>
      _$ChatCompletionsBodyFromJson(json);
}
