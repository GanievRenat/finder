import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_model.freezed.dart';
part 'memory_model.g.dart';

@freezed
abstract class MemoryModel with _$MemoryModel {
  const factory MemoryModel({
    @Default('') @JsonKey(name: 'slots') String slots,
  }) = _MemoryModel;

  factory MemoryModel.fromJson(Map<String, Object?> json) =>
      _$MemoryModelFromJson(json);
}

/*extension PersonModelToEntites on FilterStateModel {
  FilterData toEntites() {
    return FilterData(
      tags: tags,
      selectTags: selectTags,
      interestedGender: Gender.values[genderIndex],
    );
  }
}*/
