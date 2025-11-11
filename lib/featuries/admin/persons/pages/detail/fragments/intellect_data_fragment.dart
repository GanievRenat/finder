import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class IntellectDataFragment extends StatelessWidget {
  const IntellectDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Intellect',
      child: Column(
        children: [
          SegmentValueTen(
            title: 'Depth',
            initValue: state?.intellectDepth,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(intellectDepth: value)
                    : state.copyWith(intellectDepth: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
