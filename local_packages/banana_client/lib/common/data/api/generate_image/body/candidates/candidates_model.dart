import 'package:freezed_annotation/freezed_annotation.dart';
import 'content/content_model.dart';

part 'candidates_model.freezed.dart';
part 'candidates_model.g.dart';

@freezed
abstract class CandidatesModel with _$CandidatesModel {
  const factory CandidatesModel({
    @JsonKey(name: 'contents') @Default([]) List<ContentModel> contents,
  }) = _CandidatesModel;

  factory CandidatesModel.fromJson(Map<String, Object?> json) =>
      _$CandidatesModelFromJson(json);
}
