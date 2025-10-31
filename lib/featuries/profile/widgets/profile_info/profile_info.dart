import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/profile.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.onAgeEdit,
    required this.onNameEdit,
    required this.onGenderEdit,
  });

  final Function(int initAge) onAgeEdit;
  final Function(int initGenderIndex) onGenderEdit;
  final Function(String initName) onNameEdit;

  @override
  Widget build(BuildContext context) {
    return ProfileBuilder(
      init: (BuildContext context) => ProfileInfoLoading(),
      loading: (BuildContext context) => ProfileInfoLoading(),
      error: (BuildContext context, value, Widget? child) => ProfileInfoError(),
      success: (BuildContext context, value, Widget? child) => ProfileInfoData(
        user: value,
        onAgeEdit: onAgeEdit,
        onGenderEdit: onGenderEdit,
        onNameEdit: onNameEdit,
      ),
    );
  }
}

class ProfileInfoData extends StatelessWidget {
  const ProfileInfoData({
    super.key,
    required this.user,
    required this.onAgeEdit,
    required this.onGenderEdit,
    required this.onNameEdit,
  });

  final User user;

  final Function(int initAge) onAgeEdit;
  final Function(int initGenderIndex) onGenderEdit;
  final Function(String initName) onNameEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTileProfileItem(
          title: LocaleKeys.user_profile_menu_your_profile_field_name.tr(),
          subtitle: user.name,
          onTap: () => onNameEdit(user.name),
        ),
        AppSpacing.vertical.s3,
        ListTileProfileItem(
          title: LocaleKeys.user_profile_menu_your_profile_field_gender.tr(),
          subtitle: user.gender?.getGenderName() ?? '',
          onTap: () => onGenderEdit((user.gender ?? Gender.male).index),
        ),
        AppSpacing.vertical.s3,
        ListTileProfileItem(
          title: LocaleKeys.user_profile_menu_your_profile_field_age.tr(),
          subtitle: '${user.age}',
          onTap: () => onAgeEdit(user.age),
        ),
      ],
    );
  }
}

class ProfileInfoError extends StatelessWidget {
  const ProfileInfoError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTileProfileItem(
          title: LocaleKeys.user_profile_menu_your_profile_field_name.tr(),
          subtitle: '-/-',
          onTap: () {},
        ),
        AppSpacing.vertical.s3,
        ListTileProfileItem(
          title: LocaleKeys.user_profile_menu_your_profile_field_gender.tr(),
          subtitle: '-/-',
          onTap: () {},
        ),
        AppSpacing.vertical.s3,
        ListTileProfileItem(
          title: LocaleKeys.user_profile_menu_your_profile_field_age.tr(),
          subtitle: '-/-',
          onTap: () {},
        ),
      ],
    );
  }
}

class ProfileInfoLoading extends StatelessWidget {
  const ProfileInfoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      ignoreContainers: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTileProfileItem(
            title: LocaleKeys.user_profile_menu_your_profile_field_name.tr(),
            subtitle: 'Sara',
            onTap: () {},
          ),
          AppSpacing.vertical.s3,
          ListTileProfileItem(
            title: LocaleKeys.user_profile_menu_your_profile_field_gender.tr(),
            subtitle: 'Male',
            onTap: () {},
          ),
          AppSpacing.vertical.s3,
          ListTileProfileItem(
            title: LocaleKeys.user_profile_menu_your_profile_field_age.tr(),
            subtitle: '24',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
