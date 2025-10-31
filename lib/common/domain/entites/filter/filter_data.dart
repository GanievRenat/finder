import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/enums.dart';

class FilterData extends Equatable {
  final Gender interestedGender;
  final List<String> tags;
  final List<String> selectTags;

  const FilterData({
    required this.interestedGender,
    required this.tags,
    required this.selectTags,
  });

  const FilterData.empty()
    : interestedGender = Gender.none,
      tags = const [],
      selectTags = const [];

  FilterData copyWith({
    Gender? interestedGender,
    List<String>? tags,
    List<String>? selectTags,
  }) {
    return FilterData(
      interestedGender: interestedGender ?? this.interestedGender,
      tags: tags ?? this.tags,
      selectTags: selectTags ?? this.selectTags,
    );
  }

  @override
  List<Object?> get props => [interestedGender, tags, selectTags];
}
