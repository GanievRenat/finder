import 'package:flirta/common/domain/entites/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_request_model.freezed.dart';
part 'photo_request_model.g.dart';

@freezed
abstract class PhotoRequestModel with _$PhotoRequestModel {
  const factory PhotoRequestModel({
    @Default(false) @JsonKey(name: 'user_need_photo') bool userNeedPhoto,
    @Default('') @JsonKey(name: 'your_answer') String yourAnswer,
    @Default('') @JsonKey(name: 'generation_request') String generationRequest,
  }) = _PhotoRequestModel;

  factory PhotoRequestModel.fromJson(Map<String, Object?> json) =>
      _$PhotoRequestModelFromJson(json);
}
