import 'package:equatable/equatable.dart';

import 'prompt_tokens_details/prompt_tokens_details.dart';

class Usage extends Equatable {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;
  final int promptCacheHitTokens;
  final int promptCacheMissTokens;
  final PromptTokensDetails? promptTokensDetails;

  const Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.promptCacheHitTokens,
    required this.promptCacheMissTokens,
    required this.promptTokensDetails,
  });

  @override
  List<Object?> get props => [
    promptTokens,
    completionTokens,
    totalTokens,
    promptCacheHitTokens,
    promptCacheMissTokens,
    promptTokensDetails,
  ];
}
