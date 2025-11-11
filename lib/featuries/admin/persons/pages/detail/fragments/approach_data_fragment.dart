import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/persons/pages/detail/state/person_detail_state.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApproachDataFragment extends StatelessWidget {
  const ApproachDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Approach',
      child: Column(
        children: [
          SegmentValueTen(
            title: 'Speed',
            initValue: state?.approachSpeed,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(approachSpeed: value)
                    : state.copyWith(approachSpeed: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
