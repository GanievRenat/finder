import 'package:equatable/equatable.dart';

class Prompts extends Equatable {
  final String nsfwBasePrompt;
  final String nsfwJsonDescription;
  final String nsfwPhotoFilter;
  final String nsfwPhotoQuality;
  final String sfwBasePrompt;
  final String sfwJsonDescription;
  final String sfwPhotoFilter;
  final String sfwPhotoQuality;

  const Prompts({
    required this.nsfwBasePrompt,
    required this.nsfwJsonDescription,
    required this.nsfwPhotoFilter,
    required this.nsfwPhotoQuality,
    required this.sfwBasePrompt,
    required this.sfwJsonDescription,
    required this.sfwPhotoFilter,
    required this.sfwPhotoQuality,
  });

  Prompts copyWith({
    String? nsfwBasePrompt,
    String? nsfwJsonDescription,
    String? nsfwPhotoFilter,
    String? nsfwPhotoQuality,
    String? sfwBasePrompt,
    String? sfwJsonDescription,
    String? sfwPhotoFilter,
    String? sfwPhotoQuality,
  }) {
    return Prompts(
      nsfwBasePrompt: nsfwBasePrompt ?? this.nsfwBasePrompt,
      nsfwJsonDescription: nsfwJsonDescription ?? this.nsfwJsonDescription,
      nsfwPhotoFilter: nsfwPhotoFilter ?? this.nsfwPhotoFilter,
      nsfwPhotoQuality: nsfwPhotoQuality ?? this.nsfwPhotoQuality,
      sfwBasePrompt: sfwBasePrompt ?? this.sfwBasePrompt,
      sfwJsonDescription: sfwJsonDescription ?? this.sfwJsonDescription,
      sfwPhotoFilter: sfwPhotoFilter ?? this.sfwPhotoFilter,
      sfwPhotoQuality: sfwPhotoQuality ?? this.sfwPhotoQuality,
    );
  }

  @override
  List<Object?> get props => [
    nsfwBasePrompt,
    nsfwJsonDescription,
    nsfwPhotoFilter,
    nsfwPhotoQuality,
    sfwBasePrompt,
    sfwJsonDescription,
    sfwPhotoFilter,
    sfwPhotoQuality,
  ];
}
