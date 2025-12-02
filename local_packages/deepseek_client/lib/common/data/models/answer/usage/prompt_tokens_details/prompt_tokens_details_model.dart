import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:deepseek_client/common/domain/entities/answer/usage/prompt_tokens_details/prompt_tokens_details.dart';

part 'prompt_tokens_details_model.freezed.dart';
part 'prompt_tokens_details_model.g.dart';

@freezed
abstract class PromptTokensDetailsModel with _$PromptTokensDetailsModel {
  const factory PromptTokensDetailsModel({
    @JsonKey(name: 'cached_tokens') @Default(0) int cachedTokens,
  }) = _PromptTokensDetailsModel;

  factory PromptTokensDetailsModel.fromJson(Map<String, Object?> json) =>
      _$PromptTokensDetailsModelFromJson(json);
}

extension PromptTokensDetailsModelToEntites on PromptTokensDetailsModel {
  PromptTokensDetails toEntites() {
    return PromptTokensDetails(cachedTokens: cachedTokens);
  }
}
