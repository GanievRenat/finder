import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class StyleDataFragment extends StatelessWidget {
  const StyleDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Style',
      child: Column(
        children: [
          SegmentValueTen(
            title: 'Pace',
            initValue: state?.stylePace,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(stylePace: value)
                    : state.copyWith(stylePace: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Questions Ratio',
            initValue: state?.styleQuestionsRatio,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(styleQuestionsRatio: value)
                    : state.copyWith(styleQuestionsRatio: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Flirt Level Max',
            initValue: state?.styleFlirtLevelMax,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(styleFlirtLevelMax: value)
                    : state.copyWith(styleFlirtLevelMax: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Humor',
            initValue: state?.styleHumor,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(styleHumor: value)
                    : state.copyWith(styleHumor: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Emoji',
            initValue: state?.styleEmoji,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(styleEmoji: value)
                    : state.copyWith(styleEmoji: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Formality',
            initValue: state?.styleFormality,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(styleFormality: value)
                    : state.copyWith(styleFormality: value),
              );
            },
          ),
          SegmentValueTen(
            title: 'Slang',
            initValue: state?.styleSlang,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(styleSlang: value)
                    : state.copyWith(styleSlang: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
