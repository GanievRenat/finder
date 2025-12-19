import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/answer/answer.dart';

part 'answer_model.freezed.dart';
part 'answer_model.g.dart';

@freezed
abstract class AnswerModel with _$AnswerModel {
  const factory AnswerModel({
    @JsonKey(name: 'request_id') @Default('') String requestId,
    @JsonKey(name: 'status') @Default('') String status,
    @JsonKey(name: 'download_url') @Default('') String downloadUrl,
  }) = _AnswerModel;

  factory AnswerModel.fromJson(Map<String, Object?> json) =>
      _$AnswerModelFromJson(json);
}

extension AnswerModelToEntites on AnswerModel {
  Answer toEntites() {
    //"processing" // completed, failed, processing, or cancelled

    Status status = Status.processing;
    if (this.status == 'processing') status = Status.processing;
    if (this.status == 'failed') status = Status.failed;
    if (this.status == 'completed') status = Status.completed;
    if (this.status == 'cancelled') status = Status.cancelled;

    return Answer(
      requestId: requestId,
      downloadUrl: downloadUrl,
      status: status,
    );
  }
}
