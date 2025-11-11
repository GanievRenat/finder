import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class PersonalDataFragment extends StatefulWidget {
  const PersonalDataFragment({super.key});

  @override
  State<PersonalDataFragment> createState() => _PersonalDataFragmentState();
}

class _PersonalDataFragmentState extends State<PersonalDataFragment> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Personal data',
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text('ModelId')),
            enabled: state?.modelId.isEmpty,
            initialValue: state?.modelId,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(modelId: value)
                    : state.copyWith(modelId: value),
              );
            },
          ),
          AppSpacing.vertical.s6,
          MenuSelector(
            title: 'Gender',
            initValue: state?.gender ?? '',
            values: {
              Gender.male.getGenderForInterestedName(),
              Gender.female.getGenderForInterestedName(),
              Gender.nonBinary.getGenderForInterestedName(),
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(gender: value)
                    : state.copyWith(gender: value),
              );
            },
          ),
          AppSpacing.vertical.s6,
          TextFormField(
            decoration: InputDecoration(label: Text('Name')),
            initialValue: state?.name,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(name: value)
                    : state.copyWith(name: value),
              );
            },
          ),
          AppSpacing.vertical.s6,
          TextFormField(
            decoration: InputDecoration(label: Text('Bio App')),
            initialValue: state?.bioApp,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(bioApp: value)
                    : state.copyWith(bioApp: value),
              );
            },
          ),
          if ((state?.artBio ?? '').isNotEmpty) AppSpacing.vertical.s6,
          if ((state?.artBio ?? '').isNotEmpty)
            TextFormField(
              decoration: InputDecoration(label: Text('Art Bio')),
              minLines: 10,
              maxLines: 10,
              readOnly: true,
              enableInteractiveSelection: true,
              keyboardType: TextInputType.multiline,
              initialValue: state?.artBio,
            ),
        ],
      ),
    );
  }
}
