import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/properties_service.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class VisualDataFragment extends StatefulWidget {
  const VisualDataFragment({super.key});

  @override
  State<VisualDataFragment> createState() => _VisualDataFragmentState();
}

class _VisualDataFragmentState extends State<VisualDataFragment> {
  final GlobalKey globalKeyWardrobeCapsule = GlobalKey(
    debugLabel: 'WardrobeCapsule',
  );

  final GlobalKey globalKeyClothingStyles = GlobalKey(
    debugLabel: 'ClothingStyles',
  );

  bool editDistanceError = true;
  bool wardrobeCapsuleError = true;
  bool clothingStylesError = true;

  BoxDecoration kBoxDecoration = BoxDecoration(
    color: Colors.red.shade100,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(width: 2, color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    editDistanceError = state?.visualDistinctiveFeatures.isEmpty ?? true;
    wardrobeCapsuleError = state?.visualWardrobeCapsule.isEmpty ?? true;
    clothingStylesError = state?.clothingStyles.isEmpty ?? true;

    return ContainerGroup(
      title: 'Visual',
      child: Column(
        children: [
          MenuSelector(
            title: 'Signature',
            initValue: state?.visualSignature,
            values: getIt<PropertiesService>().signature.toSet(),
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(visualSignature: value)
                    : state.copyWith(visualSignature: value),
              );
            },
          ),
          MenuSelector(
            title: 'Palette',
            initValue: state?.visualPalette,
            values: getIt<PropertiesService>().palette.toSet(),
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(visualPalette: value)
                    : state.copyWith(visualPalette: value),
              );
            },
          ),
          Container(
            decoration: wardrobeCapsuleError ? kBoxDecoration : null,
            padding: wardrobeCapsuleError ? EdgeInsets.all(16) : null,
            child: MainTagsGroup(
              key: globalKeyWardrobeCapsule,
              title: 'Wardrobe Capsule',
              tags: getIt<PropertiesService>().wardrobeCapsule.toSet(),
              initTags: state?.visualWardrobeCapsule.toSet() ?? {},
              onChanged: (selectTags) {
                final state = context.read<PersonDetailState>().personModel;
                context.read<PersonDetailState>().setNewState(
                  state == null
                      ? PersonModel(visualWardrobeCapsule: selectTags.toList())
                      : state.copyWith(
                          visualWardrobeCapsule: selectTags.toList(),
                        ),
                );
                setState(() {
                  wardrobeCapsuleError = selectTags.isEmpty;
                });
              },
            ),
          ),

          AppSpacing.vertical.s8,
          Container(
            decoration: clothingStylesError ? kBoxDecoration : null,
            padding: clothingStylesError ? EdgeInsets.all(16) : null,
            child: MainTagsGroup(
              key: globalKeyClothingStyles,
              title: 'Clothing Styles',
              tags: getIt<PropertiesService>().clothingStyles.toSet(),
              initTags: state?.clothingStyles.toSet() ?? {},
              onChanged: (selectTags) {
                final state = context.read<PersonDetailState>().personModel;
                context.read<PersonDetailState>().setNewState(
                  state == null
                      ? PersonModel(clothingStyles: selectTags.toList())
                      : state.copyWith(clothingStyles: selectTags.toList()),
                );
                setState(() {
                  clothingStylesError = selectTags.isEmpty;
                });
              },
            ),
          ),
          AppSpacing.vertical.s8,
          TextFormField(
            decoration: InputDecoration(
              label: Text('Distinctive Features'),
              errorText: (editDistanceError) ? 'Заполните поле' : null,
            ),
            initialValue: state?.visualDistinctiveFeatures,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(visualDistinctiveFeatures: value)
                    : state.copyWith(visualDistinctiveFeatures: value),
              );
              setState(() {
                editDistanceError = value.isEmpty;
              });
            },
          ),
        ],
      ),
    );
  }
}
