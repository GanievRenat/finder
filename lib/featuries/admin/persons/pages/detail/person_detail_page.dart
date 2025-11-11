import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/data/models/persons/person_mapper.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/buttons/main_button.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'fragments/detail_fragments.dart';
import 'state/person_detail_state.dart';

class PersonDetailAdminPage extends StatelessWidget {
  const PersonDetailAdminPage({
    super.key,
    this.personModel,
    required this.onDeletePerson,
  });

  final PersonModel? personModel;
  final Future<bool> Function() onDeletePerson;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonDetailState(personModel ?? PersonModel()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            personModel != null
                ? '${personModel!.name} ${personModel!.modelId}'
                : 'Create new model',
          ),
          centerTitle: false,
          actions: [
            if (personModel != null)
              IconButton(
                onPressed: () async {
                  var result = await onDeletePerson();
                  if (result && context.mounted) {
                    final state = context.read<PersonDetailState>().personModel;
                    if (state != null) {
                      getIt<RemovePerson>().call(state.modelId);
                    }
                  }
                },
                icon: Icon(Icons.delete, color: AppTheme.of(context).color.red),
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PersonalDataFragment(),
              IdentityDataFragment(),
              PhenotypeDataFragment(),
              VisualDataFragment(),
              ExpertiseDataFragment(),
              TraitsDataFragment(),
              StyleDataFragment(),
              DinamicsDataFragment(),
              ApproachDataFragment(),
              MemoryDataFragment(),
              IntellectDataFragment(),
              ComplimentsDataFragment(),
              LoyaltyDataFragment(),
              AxisDataFragment(),
              ChatDataFragment(),
              SfwOptionsDataFragment(),
              (personModel == null) ? CreateButton() : UpdateButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateButton extends StatefulWidget {
  const CreateButton({super.key});

  @override
  State<CreateButton> createState() => _CreateButtonState();
}

class _CreateButtonState extends State<CreateButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: MainButton(
        isLoading: isLoading,
        title: 'Create',
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            final state = context.read<PersonDetailState>().personModel;

            if (state != null) {
              if (state.validate()) {
                context.read<PersonDetailState>().setNewState(
                  state.copyWith(artBio: state.getArtBio()),
                );
                getIt<CreateNewPerson>().call(
                  context.read<PersonDetailState>().personModel!,
                );
              } else {
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    backgroundColor: AppTheme.of(context).color.error,
                    content: Text(
                      'Заполните все данные анкеты',
                      style: TextStyle(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    actions: [
                      MainButton.inversionSmall(
                        title: LocaleKeys.properties_buttons_ok.tr(),
                        onPressed: () => ScaffoldMessenger.of(
                          context,
                        ).clearMaterialBanners(),
                      ),
                    ],
                  ),
                );
              }
            }
          } catch (e) {
            log(e.toString());
          }
          setState(() {
            isLoading = false;
          });
          context.pop();
        },
      ),
    );
  }
}

class UpdateButton extends StatefulWidget {
  const UpdateButton({super.key});

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: MainButton(
        isLoading: isLoading,
        title: 'Update',
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            final state = context.read<PersonDetailState>().personModel;

            if (state != null) {
              if (state.validate()) {
                context.read<PersonDetailState>().setNewState(
                  state.copyWith(artBio: state.getArtBio()),
                );
                getIt<UpdatePerson>().call(
                  context.read<PersonDetailState>().personModel!,
                );
              } else {
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    backgroundColor: AppTheme.of(context).color.error,
                    content: Text(
                      'Заполните все данные анкеты',
                      style: TextStyle(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    actions: [
                      MainButton.inversionSmall(
                        title: LocaleKeys.properties_buttons_ok.tr(),
                        onPressed: () => ScaffoldMessenger.of(
                          context,
                        ).clearMaterialBanners(),
                      ),
                    ],
                  ),
                );
              }
            }
          } catch (e) {
            log(e.toString());
          }
          setState(() {
            isLoading = false;
          });
          context.pop();
        },
      ),
    );
  }
}
