import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class ExpertiseDataFragment extends StatelessWidget {
  ExpertiseDataFragment({super.key});

  final GlobalKey globalKeyHobbies = GlobalKey(debugLabel: 'hobbies');
  //final GlobalKey globalKeyMusicStyles = GlobalKey(debugLabel: 'music_styles');

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Expertise',
      child: Column(
        children: [
          MainTagsGroup(
            key: globalKeyHobbies,
            title: 'Hobbies',
            tags: {
              'afrobeats',
              'ambient',
              'animal shelter',
              'architecture',
              'art',
              'baking',
              'basketball',
              'bass guitar',
              'beach volleyball',
              'biotech',
              'board games',
              'boho acoustic',
              'bossa nova',
              'boxing',
              'business',
              'calisthenics',
              'ceramics',
              'chess',
              'classical',
              'climbing',
              'coaching',
              'coding',
              'coffee rituals',
              'communication',
              'community',
              'consulting',
              'cooking',
              'culinary arts',
              'cybersecurity',
              'cycling',
              'dancing',
              'data',
              'design',
              'djing',
              'eco-blog',
              'education',
              'electronic',
              'engineering',
              'farmers’ market',
              'film',
              'finance',
              'fintech',
              'fishing',
              'fitness',
              'folk',
              'food',
              'food photography',
              'football',
              'freediving',
              'gaming',
              'gardening',
              'healthcare',
              'hiking',
              'hip - hop',
              'house',
              'indie',
              'indie cinema',
              'indie rock',
              'jazz',
              'k-pop',
              'latin',
              'latin jazz',
              'law',
              'lofi',
              'lofi hip hop',
              'marketing',
              'media',
              'modern dance',
              'motorbikes',
              'music',
              'neo-soul',
              'operations',
              'painting',
              'photography',
              'piano',
              'pop',
              'product',
              'psychology',
              'punk',
              'r&b',
              'reading',
              'reggae',
              'research',
              'rock',
              'running',
              'sailing',
              'science',
              'singing',
              'skating',
              'smoothies',
              'snowboarding',
              'songwriting',
              'sports science',
              'stand-up',
              'strategy',
              'street jazz',
              'SUP',
              'surfing',
              'sustainability',
              'swimming',
              'table tennis',
              'tech',
              'technology',
              'trail running',
              'traveling',
              'ui',
              'urban sketching',
              'web',
              'wellbeing',
              'wild swimming',
              'woodworking',
              'writing',
              'yoga',
            },
            initTags: state?.expertiseHobbies.toSet() ?? {},
            onChanged: (selectTags) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(expertiseHobbies: selectTags.toList())
                    : state.copyWith(expertiseHobbies: selectTags.toList()),
              );
            },
          ),
          /*MainTagsGroup(
            key: globalKeyHobbies,
            title: 'Hobbies',
            tags: List.generate(
              49,
              (index) => 'filter.interests_tags.$index'.tr(),
            ).toSet(),
            initTags: {},
            onChanged: (selectTags) {
              //getIt<FilterCubit>().setNewSelectTags(selectTags);
            },
          ),*/
          //AppSpacing.vertical.s8,
          /*MainTagsGroup(
            key: globalKeyMusicStyles,
            title: 'Music Styles',
            tags: {
              'Pop',
              'Rock',
              'Hip-Hop',
              'Rap',
              'R&B',
              'Jazz',
              'Blues',
              'Classical',
              'Electronic',
              'Dance',
              'House',
              'Techno',
              'Trance',
              'Dubstep',
              'Reggae',
              'Country',
              'Folk',
              'Metal',
              'Punk',
              'Soul',
            },
            initTags: {},
            onChanged: (selectTags) {
              //getIt<FilterCubit>().setNewSelectTags(selectTags);
            },
          ),*/
        ],
      ),
    );
  }
}
