import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class AxisDataFragment extends StatelessWidget {
  const AxisDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Axis',
      child: Column(
        children: [
          SegmentValueTen(
            title: 'Sensing Intuition',
            initValue: state?.axisSensingIntuition,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(axisSensingIntuition: value)
                    : state.copyWith(axisSensingIntuition: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Thinking Feeling',
            initValue: state?.axisThinkingFeeling,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(axisThinkingFeeling: value)
                    : state.copyWith(axisThinkingFeeling: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Extraversion Introversion',
            initValue: state?.axisExtraversionIntroversion,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(axisExtraversionIntroversion: value)
                    : state.copyWith(axisExtraversionIntroversion: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Judging Perceiving',
            initValue: state?.axisJudgingPerceiving,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(axisJudgingPerceiving: value)
                    : state.copyWith(axisJudgingPerceiving: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
