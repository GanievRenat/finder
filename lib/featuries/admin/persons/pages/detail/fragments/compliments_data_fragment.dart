import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class ComplimentsDataFragment extends StatelessWidget {
  const ComplimentsDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Compliments',
      child: Column(
        children: [
          SegmentValueTen(
            title: 'to Intellect',
            initValue: state?.complimentsToIntellect,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(complimentsToIntellect: value)
                    : state.copyWith(complimentsToIntellect: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'to Physique',
            initValue: state?.complimentsToPhysique,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(complimentsToPhysique: value)
                    : state.copyWith(complimentsToPhysique: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Intensity',
            initValue: state?.complimentsIntensity,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(complimentsIntensity: value)
                    : state.copyWith(complimentsIntensity: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Cooldown msgs',
            initValue: state?.complimentsCooldownMsgs,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(complimentsCooldownMsgs: value)
                    : state.copyWith(complimentsCooldownMsgs: value),
              );
            },
          ),
          MenuSelector(
            title: 'Triggers',
            initValue: state?.complimentsTriggers,
            values: {
              'achievements; initiative; humor',
              'achievements; kindness; patience',
              'achievements; vulnerability; humor',
              'metrics_shared; training_story; clear_plan',
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(complimentsTriggers: value)
                    : state.copyWith(complimentsTriggers: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
