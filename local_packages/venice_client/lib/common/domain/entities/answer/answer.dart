import 'package:venice_client/common/domain/enums/models_enums.dart';
import 'package:equatable/equatable.dart';

import 'choices/choice.dart';
import 'usage/usage.dart';

class Answer extends Equatable {
  final String id;
  final String object;
  final int created;
  final ModelsEnums model;
  final String systemFingerprint;
  final List<Choice> choices;
  final Usage? usage;

  const Answer({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.systemFingerprint,
    required this.choices,
    required this.usage,
  });

  @override
  List<Object?> get props => [
    id,
    object,
    created,
    model,
    systemFingerprint,
    choices,
    usage,
  ];
}
