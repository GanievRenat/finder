import 'package:equatable/equatable.dart';

class PromptTokensDetails extends Equatable {
  final int cachedTokens;

  const PromptTokensDetails({required this.cachedTokens});

  @override
  List<Object?> get props => [cachedTokens];
}
