import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class LoyaltyDataFragment extends StatelessWidget {
  const LoyaltyDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Loyalty',
      child: Column(
        children: [
          SegmentValueTen(
            title: 'Exclusivity Preference',
            initValue: state?.loyaltyExclusivityPreference,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(loyaltyExclusivityPreference: value)
                    : state.copyWith(loyaltyExclusivityPreference: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
