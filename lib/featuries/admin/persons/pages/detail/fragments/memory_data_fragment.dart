import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class MemoryDataFragment extends StatelessWidget {
  const MemoryDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Slots',
      child: Column(
        children: [
          MenuSelector(
            title: 'Escalation Triggers',
            initValue: state?.memorySlots,
            values: {
              'user_name; city; language; interests; taboos; weekly_goals',
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(memorySlots: value)
                    : state.copyWith(memorySlots: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
