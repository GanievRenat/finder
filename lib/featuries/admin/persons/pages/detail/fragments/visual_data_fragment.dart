import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/person_detail_state.dart';

class VisualDataFragment extends StatelessWidget {
  VisualDataFragment({super.key});
  final GlobalKey globalKeyWardrobeCapsule = GlobalKey(
    debugLabel: 'WardrobeCapsule',
  );

  final GlobalKey globalKeyClothingStyles = GlobalKey(
    debugLabel: 'ClothingStyles',
  );

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonDetailState>().personModel;

    return ContainerGroup(
      title: 'Visual',
      child: Column(
        children: [
          MenuSelector(
            title: 'Signature',
            initValue: state?.visualSignature,
            values: {
              'artsy flair',
              'clean lines',
              'delicate scar on brow',
              'dimples',
              'left-handed',
              'modern chic',
              'natural elegance',
              'right-handed',
              'sporty minimal',
            },
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
            values: {
              'bold contrasts',
              'cool',
              'cool pastels',
              'cool_silver',
              'cozy_neutral',
              'earth tones',
              'earthy_olive',
              'neutral',
              'sunset_warm',
              'urban_contrast',
              'vivid',
              'warm',
              'warm neutrals',
            },
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(visualPalette: value)
                    : state.copyWith(visualPalette: value),
              );
            },
          ),
          MainTagsGroup(
            key: globalKeyWardrobeCapsule,
            title: 'Wardrobe Capsule',

            tags: {
              'athleisure',
              'boho modern',
              'boho_soft',
              'casual chic',
              'city_comfy',
              'evening_simple',
              'cafe_smart',
              'classic feminine',
              'elegant_modern',
              'minimalist classic',
              'smart casual',
              'sporty_minimal',
              'office_casual',
              'night_out',
              'summer_light',
              'vintage_touch',
              'smart_casual',
              'tailored essentials',
              'tech_basic',
              'denim_focus',
              'monochrome',
              'vintage_chic',
            },
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
            },
          ),
          AppSpacing.vertical.s8,
          TextFormField(
            decoration: InputDecoration(label: Text('Distinctive Features')),
            initialValue: state?.visualDistinctiveFeatures,
            onChanged: (value) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(visualDistinctiveFeatures: value)
                    : state.copyWith(visualDistinctiveFeatures: value),
              );
            },
          ),
          AppSpacing.vertical.s8,
          MainTagsGroup(
            key: globalKeyClothingStyles,
            title: 'Clothing Styles',
            tags: {
              'artsy',
              'athletic',
              'boho',
              'minimalist',
              'preppy',
              'tailored',
              'vintage',
              'streetwear',
              'casual',
              'edgy',
              'elegant',
              'minimal',
              'romantic',
              'smart_casual',
              'athleisure',
              'sporty',
            },
            initTags: state?.clothingStyles.toSet() ?? {},
            onChanged: (selectTags) {
              final state = context.read<PersonDetailState>().personModel;
              context.read<PersonDetailState>().setNewState(
                state == null
                    ? PersonModel(clothingStyles: selectTags.toList())
                    : state.copyWith(clothingStyles: selectTags.toList()),
              );
            },
          ),
        ],
      ),
    );
  }
}
