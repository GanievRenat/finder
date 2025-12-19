import 'package:freezed_annotation/freezed_annotation.dart';

part 'inline_data_model.freezed.dart';
part 'inline_data_model.g.dart';

@freezed
abstract class InlineDataModel with _$InlineDataModel {
  const factory InlineDataModel({
    @JsonKey(name: 'mimeType') @Default('') String mimeType,
    @Default('') String data,
  }) = _InlineDataModel;

  factory InlineDataModel.fromJson(Map<String, Object?> json) =>
      _$InlineDataModelFromJson(json);
}
