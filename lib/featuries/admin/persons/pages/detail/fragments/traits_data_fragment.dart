import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class TraitsDataFragment extends StatelessWidget {
  const TraitsDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Traits',
      child: Column(
        children: [
          SegmentValueTen(
            title: 'Empathy',
            initValue: state?.traitsEmpathy,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(traitsEmpathy: value)
                    : state.copyWith(traitsEmpathy: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Playfulness',
            initValue: state?.traitsPlayfulness,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(traitsPlayfulness: value)
                    : state.copyWith(traitsPlayfulness: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Directness',
            initValue: state?.traitsDirectness,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(traitsDirectness: value)
                    : state.copyWith(traitsDirectness: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Intellect Support',
            initValue: state?.traitsIntellectSupport,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(traitsIntellectSupport: value)
                    : state.copyWith(traitsIntellectSupport: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Nurture Challenge',
            initValue: state?.traitsNurtureChallenge,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(traitsNurtureChallenge: value)
                    : state.copyWith(traitsNurtureChallenge: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Novelty',
            initValue: state?.traitsNovelty,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(traitsNovelty: value)
                    : state.copyWith(traitsNovelty: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Romance',
            initValue: state?.traitsRomance,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(traitsRomance: value)
                    : state.copyWith(traitsRomance: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
