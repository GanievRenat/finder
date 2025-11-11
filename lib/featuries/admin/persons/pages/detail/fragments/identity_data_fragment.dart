import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class IdentityDataFragment extends StatelessWidget {
  const IdentityDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Identity',
      child: Column(
        children: [
          AgeBand(
            initValue: state?.identityAgeBand,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(identityAgeBand: value)
                    : state.copyWith(identityAgeBand: value),
              );
            },
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('City')),
            initialValue: state?.identityCity,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(identityCity: value)
                    : state.copyWith(identityCity: value),
              );
            },
          ),
          MenuSelector(
            title: 'Ethnicity',
            initValue: state?.identityEthnicity,
            values: {
              'African',
              'African American',
              'Asian',
              'Asian American (Chinese American)',
              'Black African',
              'East Asian',
              'European',
              'Latina',
              'Latina (Mexican American)',
              'Latino',
              'Middle Eastern',
              'Mixed Heritage',
              'South Asian',
              'South Asian American (Indian heritage)',
              'White American',
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(identityEthnicity: value)
                    : state.copyWith(identityEthnicity: value),
              );
            },
          ),
          MenuSelector(
            title: 'Occupation',
            initValue: state?.identityOccupation,
            values: {
              'architect',
              'bioengineering student, weekend barista',
              'chef',
              'chef & restaurateur',
              'consultant',
              'data analyst',
              'data scientist',
              'doctor',
              'documentary filmmaker',
              'documentary photographer',
              'entrepreneur',
              'ER nurse',
              'fashion designer',
              'fashion stylist',
              'filmmaker',
              'fitness coach and yoga instructor',
              'frontend developer',
              'gallery curator',
              'illustrator',
              'industrial designer',
              'interior designer',
              'journalist',
              'marine biologist',
              'marketer',
              'music marketer',
              'musician',
              'operations manager',
              'photographer',
              'product manager',
              'product manager in fintech',
              'psychologist',
              'researcher',
              'software engineer',
              'software product manager',
              'sustainability consultant',
              'teacher',
              'technology lawyer',
              'travel blogger',
              'travel journalist',
              'urban planner',
              'UX designer',
              'venture analyst',
              'yoga instructor',
              'young chef',
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(identityOccupation: value)
                    : state.copyWith(identityOccupation: value),
              );
            },
          ),
          MenuSelector(
            title: 'Lifestyle',
            initValue: state?.identityLifestyle,
            values: {
              'active professional',
              'ambitious learner',
              'busy creative',
              'centered',
              'creative nomad',
              'creative wanderer',
              'eco-minded',
              'foodie',
              'helper',
              'high-energy',
              'home - oriented',
              'home-centered',
              'minimalist',
              'music scene',
              'nature lover',
              'slow living',
              'student',
              'tech creative',
              'traveler',
              'urban professional',
              'wellness',
              'wellness enthusiast',
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(identityLifestyle: value)
                    : state.copyWith(identityLifestyle: value),
              );
            },
          ),
          MenuSelector(
            title: 'Goal',
            initValue: state?.identityGoal,
            values: {
              'balance and peace',
              'building something meaningful',
              'career growth',
              'creating impact',
              'creative exploration',
              'creative freedom',
              'emotional connection',
              'financial independence',
              'flirt/romance',
              'friendly_date',
              'inner balance',
              'leading a team',
              'mastery',
              'new experiences',
              'publishing a book',
              'self - discovery',
              'slow_burn',
              'smart_flirt',
              'warm_connect',
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(identityGoal: value)
                    : state.copyWith(identityGoal: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
