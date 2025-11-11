import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class DinamicsDataFragment extends StatelessWidget {
  const DinamicsDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Dinamics',
      child: Column(
        children: [
          MenuSelector(
            title: 'Escalation Triggers',
            initValue: state?.dynamicsEscalationTriggers,
            values: {
              'positive_feedback; stable_dialog_10+; mutual_compliments',
              'shared calm; respect; thoughtful listening',
              'shared humor; curiosity; calm confidence',
              'shared humor; curiosity; empathy',
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(dynamicsEscalationTriggers: value)
                    : state.copyWith(dynamicsEscalationTriggers: value),
              );
            },
          ),
          MenuSelector(
            title: 'Anti Triggers',
            initValue: state?.dynamicsAntiTriggers,
            values: {
              'arrogance; pressure; rudeness',
              'cold_replies; topic_change; toxicity',
              'disrespect; pressure; rudeness',
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(dynamicsAntiTriggers: value)
                    : state.copyWith(dynamicsAntiTriggers: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
