import 'package:equatable/equatable.dart';

class Prompts extends Equatable {
  final String basePrompt;
  final String jsonDescription;
  final String photoFilter;
  final String photoQuality;

  const Prompts({
    required this.basePrompt,
    required this.jsonDescription,
    required this.photoFilter,
    required this.photoQuality,
  });

  Prompts copyWith({
    String? basePrompt,
    String? jsonDescription,
    String? photoFilter,
    String? photoQuality,
  }) {
    return Prompts(
      basePrompt: basePrompt ?? this.basePrompt,
      jsonDescription: jsonDescription ?? this.jsonDescription,
      photoFilter: photoFilter ?? this.photoFilter,
      photoQuality: photoQuality ?? this.photoQuality,
    );
  }

  @override
  List<Object?> get props => [
    basePrompt,
    jsonDescription,
    photoFilter,
    photoQuality,
  ];
}
