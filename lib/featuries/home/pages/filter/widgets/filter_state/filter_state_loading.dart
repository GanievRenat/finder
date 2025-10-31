import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../common/ui/widgets/widgets.dart';

class FilterStateLoading extends StatefulWidget {
  const FilterStateLoading({super.key});

  @override
  State<FilterStateLoading> createState() => _FilterStateLoadingState();
}

class _FilterStateLoadingState extends State<FilterStateLoading> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
            child: Skeletonizer(
              enabled: true,
              ignoreContainers: false,
              child: GenderTagsGroup(
                title: LocaleKeys.filter_preference.tr(),
                initGender: Gender.female,
                onChanged: (newGender) {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 32,
              right: 16,
              bottom: 16,
            ),
            child: Skeletonizer(
              enabled: true,
              ignoreContainers: false,
              child: MainTagsGroup(
                title: LocaleKeys.filter_interests.tr(),
                tags: {
                  'Cooking',
                  'Gamer',
                  'Handmade',
                  'Psychology',
                  'Design',
                  'Piercing',
                },
                initTags: {'Cooking', 'Psychology'},
                onChanged: (selectTags) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
