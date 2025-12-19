import 'package:freezed_annotation/freezed_annotation.dart';
import 'inline_data/inline_data_model.dart';

part 'parts_model.freezed.dart';
part 'parts_model.g.dart';

@freezed
abstract class PartsModel with _$PartsModel {
  const factory PartsModel({
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'inline_data') InlineDataModel? inlineData,
  }) = _PartsModel;

  factory PartsModel.fromJson(Map<String, Object?> json) =>
      _$PartsModelFromJson(json);
}
