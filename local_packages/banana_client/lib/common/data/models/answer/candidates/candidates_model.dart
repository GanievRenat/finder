import 'package:freezed_annotation/freezed_annotation.dart';
import 'content/content_model.dart';

part 'candidates_model.freezed.dart';
part 'candidates_model.g.dart';

@freezed
abstract class CandidatesModel with _$CandidatesModel {
  const factory CandidatesModel({
    @JsonKey(name: 'content') ContentModel? content,
    @JsonKey(name: 'finishReason') @Default('') String finishReason,
    @JsonKey(name: 'index') @Default(0) int index,
  }) = _CandidatesModel;

  factory CandidatesModel.fromJson(Map<String, Object?> json) =>
      _$CandidatesModelFromJson(json);
}
