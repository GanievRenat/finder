import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/properties_service.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class PhenotypeDataFragment extends StatefulWidget {
  const PhenotypeDataFragment({super.key});

  @override
  State<PhenotypeDataFragment> createState() => _PhenotypeDataFragmentState();
}

class _PhenotypeDataFragmentState extends State<PhenotypeDataFragment> {
  bool editBMIError = true;

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    editBMIError = state?.phenotypeBmi.isEmpty ?? true;

    return ContainerGroup(
      title: 'Phenotype',
      child: Column(
        children: [
          MenuSelector(
            title: 'Body Type',
            initValue: state?.phenotypeBodyType,
            values: getIt<PropertiesService>().bodyType.toSet(),
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(phenotypeBodyType: value)
                    : state.copyWith(phenotypeBodyType: value),
              );
            },
          ),
          MenuSelector(
            title: 'Somatotype',
            initValue: state?.phenotypeSomatotype,
            values: getIt<PropertiesService>().somatoType.toSet(),
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(phenotypeSomatotype: value)
                    : state.copyWith(phenotypeSomatotype: value),
              );
            },
          ),
          MenuSelector(
            title: 'Face Type',
            initValue: state?.phenotypeFaceType,
            values: getIt<PropertiesService>().faceType.toSet(),
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(phenotypeFaceType: value)
                    : state.copyWith(phenotypeFaceType: value),
              );
            },
          ),
          MenuSelector(
            title: 'Hair Texture',
            initValue: state?.phenotypeHairTexture,
            values: getIt<PropertiesService>().hairTexture.toSet(),
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(phenotypeHairTexture: value)
                    : state.copyWith(phenotypeHairTexture: value),
              );
            },
          ),
          MenuSelector(
            title: 'Hair Color',
            initValue: state?.phenotypeHairColor,
            values: getIt<PropertiesService>().hairColor.toSet(),
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(phenotypeHairColor: value)
                    : state.copyWith(phenotypeHairColor: value),
              );
            },
          ),
          MenuSelector(
            title: 'Eyes Color',
            initValue: state?.phenotypeEyesColor,
            values: getIt<PropertiesService>().eyesColor.toSet(),
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(phenotypeEyesColor: value)
                    : state.copyWith(phenotypeEyesColor: value),
              );
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text('BMI'),
              errorText: (editBMIError) ? 'Заполните поле' : null,
            ),
            initialValue: state?.phenotypeBmi,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(phenotypeBmi: value)
                    : state.copyWith(phenotypeBmi: value),
              );
              setState(() {
                editBMIError = value.isEmpty;
              });
            },
          ),
        ],
      ),
    );
  }
}
