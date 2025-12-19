import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/properties_service.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class IdentityDataFragment extends StatefulWidget {
  const IdentityDataFragment({super.key});

  @override
  State<IdentityDataFragment> createState() => _IdentityDataFragmentState();
}

class _IdentityDataFragmentState extends State<IdentityDataFragment> {
  bool editCityError = true;

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    editCityError = state?.identityCity.isEmpty ?? true;

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
          AppSpacing.vertical.s6,
          TextFormField(
            decoration: InputDecoration(
              label: Text('City'),
              errorText: editCityError ? 'Заполните поле' : null,
            ),
            initialValue: state?.identityCity,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(identityCity: value)
                    : state.copyWith(identityCity: value),
              );
              setState(() {
                editCityError = value.isEmpty;
              });
            },
          ),
          AppSpacing.vertical.s6,
          MenuSelector(
            title: 'Ethnicity',
            initValue: state?.identityEthnicity,
            values: getIt<PropertiesService>().ethnicity.toSet(),
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
            values: getIt<PropertiesService>().occupation.toSet(),
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
            values: getIt<PropertiesService>().lifestyle.toSet(),
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
            values: getIt<PropertiesService>().goal.toSet(),
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
