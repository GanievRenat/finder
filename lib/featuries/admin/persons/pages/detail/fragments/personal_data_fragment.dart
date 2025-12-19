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
  bool editModelIdError = true;
  bool editNameError = true;
  bool editBioAppError = true;

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    editModelIdError = state?.modelId.isEmpty ?? true;
    editNameError = state?.name.isEmpty ?? true;
    editBioAppError = state?.bioApp.isEmpty ?? true;

    return ContainerGroup(
      title: 'Personal data',
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              label: Text('ModelId'),
              errorText: (editModelIdError) ? 'Заполните поле' : null,
            ),
            initialValue: state?.modelId,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(modelId: value)
                    : state.copyWith(modelId: value),
              );
              setState(() {
                editModelIdError = value.isEmpty;
              });
            },
          ),

          AppSpacing.vertical.s6,
          TextFormField(
            decoration: InputDecoration(
              label: Text('Name'),
              errorText: (editNameError) ? 'Заполните поле' : null,
            ),
            initialValue: state?.name,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(name: value)
                    : state.copyWith(name: value),
              );
              setState(() {
                editNameError = value.isEmpty;
              });
            },
          ),
          AppSpacing.vertical.s6,
          TextFormField(
            decoration: InputDecoration(
              label: Text('Bio App'),
              errorText: (editBioAppError) ? 'Заполните поле' : null,
            ),
            initialValue: state?.bioApp,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(bioApp: value)
                    : state.copyWith(bioApp: value),
              );
              setState(() {
                editBioAppError = value.isEmpty;
              });
            },
          ),
          if ((state?.artBio ?? '').isNotEmpty) AppSpacing.vertical.s6,
          if ((state?.artBio ?? '').isNotEmpty)
            TextFormField(
              decoration: InputDecoration(label: Text('Art Bio')),
              minLines: 5,
              maxLines: 5,
              readOnly: true,
              enableInteractiveSelection: true,
              keyboardType: TextInputType.multiline,
              initialValue: state?.artBio,
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
        ],
      ),
    );
  }
}
