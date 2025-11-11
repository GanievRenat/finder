import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class PhenotypeDataFragment extends StatelessWidget {
  const PhenotypeDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Phenotype',
      child: Column(
        children: [
          MenuSelector(
            title: 'Body Type',
            initValue: state?.phenotypeBodyType,
            values: {
              'athletic',
              'average',
              'broad - shouldered',
              'curvy',
              'medium build',
              'pear',
              'petite',
              'rectangle',
              'slim',
            },
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
            values: {'ectomorph', 'endomorph', 'mesomorph'},
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
            values: {'diamond', 'heart', 'oval', 'round', 'square'},
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(phenotypeFaceType: value)
                    : state.copyWith(phenotypeFaceType: value),
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: MenuSelector(
                  title: 'Hair Texture',
                  initValue: state?.phenotypeHairTexture,
                  values: {'coily', 'curly', 'straight', 'wavy'},
                  onChanged: (value) {
                    final state = context.read<PersonDetailState>().personModel;
                    context.read<PersonDetailState>().setNewState(
                      state == null
                          ? PersonModel(phenotypeHairTexture: value)
                          : state.copyWith(phenotypeHairTexture: value),
                    );
                  },
                ),
              ),
              Expanded(
                child: MenuSelector(
                  title: 'Hair Color',
                  initValue: state?.phenotypeHairColor,
                  values: {
                    'auburn',
                    'black',
                    'black-brown',
                    'blonde',
                    'blue',
                    'blue - black',
                    'brown',
                    'brunette',
                    'chestnut',
                    'copper',
                    'dark brown',
                    'dirty blonde',
                    'espresso',
                    'gray',
                    'green',
                    'honey blonde',
                    'light brown',
                    'pink',
                    'platinum',
                    'purple',
                    'red',
                    'rose gold',
                    'salt - and - pepper',
                    'silver',
                    'teal',
                  },
                  onChanged: (value) {
                    final state = context.read<PersonDetailState>().personModel;
                    context.read<PersonDetailState>().setNewState(
                      state == null
                          ? PersonModel(phenotypeHairColor: value)
                          : state.copyWith(phenotypeHairColor: value),
                    );
                  },
                ),
              ),
            ],
          ),
          MenuSelector(
            title: 'Eyes Color',
            initValue: state?.phenotypeEyesColor,
            values: {
              'amber',
              'blue',
              'brown',
              'dark brown',
              'gray',
              'green',
              'hazel',
            },
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
            decoration: InputDecoration(label: Text('BMI')),
            initialValue: state?.phenotypeBmi,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(phenotypeBmi: value)
                    : state.copyWith(phenotypeBmi: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
