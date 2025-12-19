import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/properties_service.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class ExpertiseDataFragment extends StatefulWidget {
  const ExpertiseDataFragment({super.key});

  @override
  State<ExpertiseDataFragment> createState() => _ExpertiseDataFragmentState();
}

class _ExpertiseDataFragmentState extends State<ExpertiseDataFragment> {
  final GlobalKey globalKeyHobbies = GlobalKey(debugLabel: 'hobbies');

  bool hobbiesError = true;

  //final GlobalKey globalKeyMusicStyles = GlobalKey(debugLabel: 'music_styles');
  BoxDecoration kBoxDecoration = BoxDecoration(
    color: Colors.red.shade100,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(width: 2, color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    hobbiesError = state?.expertiseHobbies.isEmpty ?? true;

    return ContainerGroup(
      title: 'Expertise',
      child: Column(
        children: [
          Container(
            decoration: hobbiesError ? kBoxDecoration : null,
            padding: hobbiesError ? EdgeInsets.all(16) : null,
            child: MainTagsGroup(
              key: globalKeyHobbies,
              title: 'Hobbies',
              tags: getIt<PropertiesService>().hobbies.toSet(),
              initTags: state?.expertiseHobbies.toSet() ?? {},
              onChanged: (selectTags) {
                final state = context.read<PersonDetailState>().personModel;
                context.read<PersonDetailState>().setNewState(
                  state == null
                      ? PersonModel(expertiseHobbies: selectTags.toList())
                      : state.copyWith(expertiseHobbies: selectTags.toList()),
                );
                setState(() {
                  hobbiesError = selectTags.isEmpty;
                });
              },
            ),
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
