import 'package:freezed_annotation/freezed_annotation.dart';
import 'message/message_model.dart';
import 'package:deepseek_client/common/domain/entities/answer/choices/choice.dart';
import 'package:deepseek_client/common/data/models/answer/choices/message/message_model.dart';

part 'choice_model.freezed.dart';
part 'choice_model.g.dart';

@freezed
abstract class ChoiceModel with _$ChoiceModel {
  const factory ChoiceModel({
    @JsonKey(name: 'index') @Default(0) int idx,
    @JsonKey(name: 'finish_reason') @Default('') String finishReason,
    required MessageModel? message,
  }) = _ChoiceModel;

  factory ChoiceModel.fromJson(Map<String, Object?> json) =>
      _$ChoiceModelFromJson(json);
}

extension ChoiceModelToEntites on ChoiceModel {
  Choice toEntites() {
    return Choice(
      index: idx,
      finishReason: finishReason,
      message: message?.toEntites(),
    );
  }
}
