import 'package:freezed_annotation/freezed_annotation.dart';

import 'candidates/content/content_model.dart';

part 'request_model.freezed.dart';
part 'request_model.g.dart';

@freezed
abstract class RequestModel with _$RequestModel {
  const factory RequestModel({
    @JsonKey(name: 'contents') @Default([]) List<ContentModel> contents,
  }) = _RequestModel;

  factory RequestModel.fromJson(Map<String, Object?> json) =>
      _$RequestModelFromJson(json);
}
