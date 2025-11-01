import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/featuries/home/pages/filter/state/filter_cubit.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../../common/ui/widgets/widgets.dart';

class FilterStateData extends StatelessWidget {
  FilterStateData({super.key, required this.filterStateData});

  final FilterData filterStateData;

  final GlobalKey globalKeyGender = GlobalKey(debugLabel: 'gender');
  final GlobalKey globalKeyInterests = GlobalKey(debugLabel: 'interests');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
            child: GenderTagsGroup(
              key: globalKeyGender,
              title: LocaleKeys.filter_preference.tr(),
              initGender: filterStateData.interestedGender,
              onChanged: (newGender) {
                getIt<FilterCubit>().setNewInterestedGender(newGender);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 32,
              right: 16,
              bottom: 16,
            ),
            child: MainTagsGroup(
              key: globalKeyInterests,
              title: LocaleKeys.filter_interests.tr(),
              tags: filterStateData.tags.toSet(),
              initTags: filterStateData.selectTags.toSet(),
              onChanged: (selectTags) {
                getIt<FilterCubit>().setNewSelectTags(selectTags);
              },
            ),
          ),
        ],
      ),
    );
  }
}
