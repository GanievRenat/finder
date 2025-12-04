import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/pages/profile/state/profile_cubit.dart';
import 'package:flirta/featuries/profile/profile.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.onEditProfile,
    required this.onNotificationSettings,
    required this.onPayWall,
  });

  final Function onEditProfile;
  final Function onNotificationSettings;
  final Function onPayWall;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    getIt<ProfileCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.user_profile_title.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BackgroundProfile(
          child: Column(
            children: [
              ProfileHead(),
              ProfilePremiumStatus(onTap: () => widget.onPayWall()),
              AppSpacing.vertical.s3,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_your_profile_title.tr(),
                onTap: () => widget.onEditProfile(),
              ),
              AppSpacing.vertical.s3,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_restore_subscription_title
                    .tr(),
                onTap: () {},
              ),
              AppSpacing.vertical.s3,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_notifications_title.tr(),
                onTap: () => widget.onNotificationSettings(),
              ),
              AppSpacing.vertical.s8,
              ListTileItem.link(
                title: LocaleKeys.user_profile_menu_term_title.tr(),
                url: 'https://levelapp.io/pages/terms',
              ),
              AppSpacing.vertical.s3,
              ListTileItem.link(
                title: LocaleKeys.user_profile_menu_privacy_policy_title.tr(),
                url: 'https://levelapp.io/pages/privacyPolicy',
              ),
              AppSpacing.vertical.s3,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_rate_app_title.tr(),
                isLink: true,
                onTap: () {},
              ),
              AppSpacing.vertical.s3,
              ListTileItem.email(
                title: LocaleKeys.user_profile_menu_contact_support_title.tr(),
                email: 'info@levelapp.io',
                queryParameters: {
                  'subject': 'Support of Flirta App',
                  'body': 'Hello!',
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
