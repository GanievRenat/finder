import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class SfwOptionsDataFragment extends StatefulWidget {
  const SfwOptionsDataFragment({super.key});

  @override
  State<SfwOptionsDataFragment> createState() => _SfwOptionsDataFragmentState();
}

class _SfwOptionsDataFragmentState extends State<SfwOptionsDataFragment> {
  bool sfw = true;

  @override
  void initState() {
    super.initState();
    final state = context.read<PersonDetailState>().personModel;
    sfw = state?.boundariesStoreSfw ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'SFW Options',
      child: Column(
        children: [
          SwitchListTile(
            value: sfw,
            onChanged: (value) {
              setState(() {
                sfw = value;
              });
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(
                        safetyNsfwPolicy: (value)
                            ? 'SFW_only'
                            : 'adult_only_explicit_allowed Sexual themes are allowed, Gradual increase in hot topics',
                        safetyBlocked: (value)
                            ? 'contacts; offline_invites; medical_legal'
                            : 'Minors, lack of consent, coercion, illegal content, dangerous instructions, bestiality, incest, exploitation, doxxing/personal information, offline exchange of contacts and service offers, harassment, hate.',
                        safetyToxicityHandler: (value)
                            ? 'soft_stop_redirect'
                            : '',
                        boundariesStoreSfw: value,
                      )
                    : state.copyWith(
                        safetyNsfwPolicy: (value)
                            ? 'SFW_only'
                            : 'adult_only_explicit_allowed Sexual themes are allowed, Gradual increase in hot topics',
                        safetyBlocked: (value)
                            ? 'contacts; offline_invites; medical_legal'
                            : 'Minors, lack of consent, coercion, illegal content, dangerous instructions, bestiality, incest, exploitation, doxxing/personal information, offline exchange of contacts and service offers, harassment, hate.',
                        safetyToxicityHandler: (value)
                            ? 'soft_stop_redirect'
                            : '',
                        boundariesStoreSfw: value,
                      ),
              );
            },
            contentPadding: EdgeInsets.zero,
            title: Text('SFW mode'),
          ),
          if (sfw)
            MenuSelector(
              key: ValueKey('Desires'),
              initValue: state?.safetyDesiresSfw,
              title: 'Desires',
              values: {
                'slow_date_rhythm; gentle_gestures; goodbye_kiss',
                'walks; coffee_dates; soft_tease',
              },
              onChanged: (value) {
                final state = context.read<PersonDetailState>().personModel;
                context.read<PersonDetailState>().setNewState(
                  state == null
                      ? PersonModel(safetyDesiresSfw: value)
                      : state.copyWith(safetyDesiresSfw: value),
                );
              },
            ),

          if (!sfw)
            MenuSelector(
              key: ValueKey('HeatRamp'),
              initValue: state?.approachHeatRamp,
              title: 'Heat Ramp',
              values: {'brisk', 'gentle', 'steady'},
              onChanged: (value) {
                final state = context.read<PersonDetailState>().personModel;
                context.read<PersonDetailState>().setNewState(
                  state == null
                      ? PersonModel(approachHeatRamp: value)
                      : state.copyWith(approachHeatRamp: value),
                );
              },
            ),
        ],
      ),
    );
  }
}
