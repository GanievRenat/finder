import '../persons/person_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_per_day_model.freezed.dart';
part 'person_per_day_model.g.dart';

@freezed
abstract class PersonPerDayModel with _$PersonPerDayModel {
  const factory PersonPerDayModel({
    @Default([]) List<PersonModel> models,
    @Default(0) int toDay,
  }) = _PersonPerDayModel;

  factory PersonPerDayModel.fromJson(Map<String, Object?> json) =>
      _$PersonPerDayModelFromJson(json);
}
