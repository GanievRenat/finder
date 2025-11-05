import 'package:equatable/equatable.dart';
import 'package:flirta/common/enums/enums.dart';

class Person extends Equatable {
  final String modelId;
  final String name;
  final int age;
  final Gender gender;
  final String job;
  final String bio;
  final String lifeStyle;
  final List<String> interests;
  final String requestToChat;
  final List<String> photos;

  const Person({
    required this.modelId,
    required this.name,
    required this.age,
    required this.gender,
    required this.bio,
    required this.job,
    this.lifeStyle = '',
    this.photos = const [],
    this.interests = const [],
    required this.requestToChat,
  });

  Person copyWith({
    String? modelId,
    String? name,
    int? age,
    Gender? gender,
    String? job,
    String? bio,
    String? lifeStyle,
    List<String>? interests,
    List<String>? photos,
    String? requestToChat,
  }) {
    return Person(
      age: age ?? this.age,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      job: job ?? this.job,
      modelId: modelId ?? this.modelId,
      name: name ?? this.name,
      requestToChat: requestToChat ?? this.requestToChat,
      interests: interests ?? this.interests,
      lifeStyle: lifeStyle ?? this.lifeStyle,
      photos: photos ?? this.photos,
    );
  }

  @override
  List<Object?> get props => [
    modelId,
    name,
    age,
    gender,
    job,
    bio,
    lifeStyle,
    interests,
    requestToChat,
    photos,
  ];
}
