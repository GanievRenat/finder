import 'package:freezed_annotation/freezed_annotation.dart';
import 'prompt_tokens_details/prompt_tokens_details_model.dart';
import 'package:venice_client/common/domain/entities/answer/usage/usage.dart';

part 'usage_model.freezed.dart';
part 'usage_model.g.dart';

@freezed
abstract class UsageModel with _$UsageModel {
  const factory UsageModel({
    @JsonKey(name: 'prompt_tokens') @Default(0) int promptTokens,
    @JsonKey(name: 'completion_tokens') @Default(0) int completionTokens,
    @JsonKey(name: 'total_tokens') @Default(0) int totalTokens,
    @JsonKey(name: 'prompt_cache_hit_tokens')
    @Default(0)
    int promptCacheHitTokens,
    @JsonKey(name: 'prompt_cache_miss_tokens')
    @Default(0)
    int promptCacheMissTokens,
    @JsonKey(name: 'prompt_tokens_details')
    PromptTokensDetailsModel? promptTokensDetails,
  }) = _UsageModel;

  factory UsageModel.fromJson(Map<String, Object?> json) =>
      _$UsageModelFromJson(json);
}

extension UsageModelToEntites on UsageModel {
  Usage toEntites() {
    return Usage(
      promptTokens: promptTokens,
      completionTokens: completionTokens,
      promptCacheHitTokens: promptCacheHitTokens,
      promptCacheMissTokens: promptCacheMissTokens,
      totalTokens: totalTokens,
      promptTokensDetails: promptTokensDetails?.toEntites(),
    );
  }
}
