import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/enums.dart';

class FilterData extends Equatable {
  final Gender interestedGender;
  final List<String> tags;
  final List<String> selectTags;
  final int ageStart;
  final int ageFinish;

  const FilterData({
    required this.interestedGender,
    required this.tags,
    required this.selectTags,
    required this.ageStart,
    required this.ageFinish,
  });

  const FilterData.empty()
    : interestedGender = Gender.none,
      tags = const [],
      selectTags = const [],
      ageStart = 18,
      ageFinish = 60;

  FilterData copyWith({
    Gender? interestedGender,
    List<String>? tags,
    List<String>? selectTags,
    int? ageStart,
    int? ageFinish,
  }) {
    return FilterData(
      interestedGender: interestedGender ?? this.interestedGender,
      tags: tags ?? this.tags,
      selectTags: selectTags ?? this.selectTags,
      ageStart: ageStart ?? this.ageStart,
      ageFinish: ageFinish ?? this.ageFinish,
    );
  }

  @override
  List<Object?> get props => [
    interestedGender,
    tags,
    selectTags,
    ageStart,
    ageFinish,
  ];
}
