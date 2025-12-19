import 'package:freezed_annotation/freezed_annotation.dart';
import 'parts/parts_model.dart';

part 'content_model.freezed.dart';
part 'content_model.g.dart';

@freezed
abstract class ContentModel with _$ContentModel {
  const factory ContentModel({
    @JsonKey(name: 'parts') @Default([]) List<PartsModel> parts,
  }) = _ContentModel;

  factory ContentModel.fromJson(Map<String, Object?> json) =>
      _$ContentModelFromJson(json);
}
