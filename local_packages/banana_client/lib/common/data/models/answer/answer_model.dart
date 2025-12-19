import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'candidates/candidates_model.dart';
import '../../../domain/entities/answer/answer.dart';

part 'answer_model.freezed.dart';
part 'answer_model.g.dart';

@freezed
abstract class AnswerModel with _$AnswerModel {
  const factory AnswerModel({
    @JsonKey(name: 'candidates') @Default([]) List<CandidatesModel> candidates,
  }) = _AnswerModel;

  factory AnswerModel.fromJson(Map<String, Object?> json) =>
      _$AnswerModelFromJson(json);
}

extension AnswerModelToEntites on AnswerModel {
  Answer toEntites() {
    if (candidates.isNotEmpty) {
      if (candidates.first.content != null) {
        if (candidates.first.content!.parts.isNotEmpty) {
          int index = candidates.first.content!.parts.indexWhere(
            (e) => e.inlineData != null,
          );
          if (index != -1) {
            var part = candidates.first.content!.parts[index];
            if (part.inlineData != null) {
              if (part.inlineData!.data.isNotEmpty) {
                var imgByte = base64.decode(part.inlineData!.data);
                return Answer(imageByte: imgByte);
              }
            }
          }
        }
      }
    }
    return Answer(imageByte: Uint8List(0));
  }
}
