import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/router/router.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/profile.dart';
import 'package:flirta/featuries/profile/widgets/profile_builder.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key, this.canEdit = false, this.onTap});

  final bool canEdit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ProfileBuilder(
      init: (BuildContext context) => ProfileInfoLoading(),
      loading: (BuildContext context) => ProfileInfoLoading(),
      error: (BuildContext context, value, Widget? child) => ProfileInfoError(),
      success: (BuildContext context, value, Widget? child) =>
          ProfileInfoData(user: value),
    );
  }
}

class ProfileInfoData extends StatelessWidget {
  const ProfileInfoData({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTileProfileItem(
          title: LocaleKeys.user_profile_menu_your_profile_field_name.tr(),
          subtitle: user.name,
          onTap: () {
            getIt<AppModalBottomSheet>().show(
              context,
              title: LocaleKeys.auth_whats_your_name_title.tr(),
              content: NameEditWidget(
                initName: user.name,
                onComplited: () {
                  context.pop();
                },
              ),
            );
          },
        ),
        AppSpacing.vertical.s3,
        ListTileProfileItem(
          title: LocaleKeys.user_profile_menu_your_profile_field_gender.tr(),
          subtitle: user.gender?.getGenderName() ?? '',
          onTap: () {
            getIt<AppModalBottomSheet>().show(
              context,
              title: LocaleKeys.auth_you_identify_title.tr(),
              content: GenderEditWidget(
                initGender: user.gender ?? Gender.male,
                onComplited: () {
                  context.pop();
                },
              ),
            );
          },
        ),
        AppSpacing.vertical.s3,
        ListTileProfileItem(
          title: LocaleKeys.user_profile_menu_your_profile_field_age.tr(),
          subtitle: '${user.age}',
          onTap: () {
            getIt<AppModalBottomSheet>().show(
              context,
              title: LocaleKeys.auth_how_old_are_you_title.tr(),
              subtitle: LocaleKeys.auth_how_old_are_you_subtitle.tr(),
              content: AgeEditWidget(
                initAge: user.age,
                onComplited: () {
                  context.pop();
                },
              ),
            );
          },
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
