import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../widgets/profile_head.dart';
import '../../widgets/profile_premium_status.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.onEditProfile,
    required this.onNotificationSettings,
  });

  final Function onEditProfile;
  final Function onNotificationSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.user_profile_title.tr())),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            top: 16,
            right: 16,
            bottom: 16 + MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            children: [
              ProfileHead(),
              ProfilePremiumStatus(),
              AppSpacing.vertical.s3,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_your_profile_title.tr(),
                onTap: () {
                  onEditProfile();
                },
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
                onTap: () {
                  onNotificationSettings();
                },
              ),
              AppSpacing.vertical.s8,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_term_title.tr(),
                isLink: true,
                onTap: () {},
              ),
              AppSpacing.vertical.s3,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_privacy_policy_title.tr(),
                isLink: true,
                onTap: () {},
              ),
              AppSpacing.vertical.s3,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_rate_app_title.tr(),
                isLink: true,
                onTap: () {},
              ),
              AppSpacing.vertical.s3,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_contact_support_title.tr(),
                isLink: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
