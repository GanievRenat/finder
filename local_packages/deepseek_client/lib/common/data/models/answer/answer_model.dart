import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:deepseek_client/common/domain/entities/answer/answer.dart';
import 'package:deepseek_client/common/domain/enums/enums.dart';
import 'choices/choice_model.dart';
import 'usage/usage_model.dart';

part 'answer_model.freezed.dart';
part 'answer_model.g.dart';

@freezed
abstract class AnswerModel with _$AnswerModel {
  const factory AnswerModel({
    @Default('') String id,
    @Default('') String object,
    @Default(0) int created,
    @Default('') String model,
    @Default('') @JsonKey(name: 'system_fingerprint') String systemFingerprint,
    @Default([]) List<ChoiceModel> choices,
    UsageModel? usage,
  }) = _AnswerModel;

  factory AnswerModel.fromJson(Map<String, Object?> json) =>
      _$AnswerModelFromJson(json);
}

extension AnswerModelToEntites on AnswerModel {
  Answer toEntites() {
    return Answer(
      id: id,
      model: (model == ModelsEnums.chat.toString()
          ? ModelsEnums.chat
          : ModelsEnums.reasoner),
      created: created,
      object: object,
      systemFingerprint: systemFingerprint,
      usage: usage?.toEntites(),
      choices: choices.map((e) => e.toEntites()).toList(),
    );
  }
}
