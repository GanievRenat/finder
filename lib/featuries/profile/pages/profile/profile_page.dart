import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/service/remote_config_service.dart';
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
  String _termUrl = '';
  String _privatePolicyUrl = '';
  String _supportEmail = '';

  @override
  void initState() {
    super.initState();

    getIt<ProfileCubit>().init();

    var remoteConfig = getIt<RemoteConfigService>();

    _termUrl = remoteConfig.menuTermURL;
    _privatePolicyUrl = remoteConfig.privacyPolicyURL;
    _supportEmail = remoteConfig.supportEmail;
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
              ProfilePremiumStatus(
                onTap: (premiumStatus) {
                  setState(() {
                    getIt<AppStateService>().premium = !premiumStatus;
                  });
                },
              ), //=> widget.onPayWall()),
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
              if (_termUrl.isNotEmpty)
                ListTileItem.link(
                  title: LocaleKeys.user_profile_menu_term_title.tr(),
                  url: _termUrl,
                ),
              if (_termUrl.isNotEmpty) AppSpacing.vertical.s3,
              if (_privatePolicyUrl.isNotEmpty)
                ListTileItem.link(
                  title: LocaleKeys.user_profile_menu_privacy_policy_title.tr(),
                  url: _privatePolicyUrl,
                ),
              if (_privatePolicyUrl.isNotEmpty) AppSpacing.vertical.s3,
              ListTileItem(
                title: LocaleKeys.user_profile_menu_rate_app_title.tr(),
                isLink: true,
                onTap: () {},
              ),
              if (_supportEmail.isNotEmpty) AppSpacing.vertical.s3,
              if (_supportEmail.isNotEmpty)
                ListTileItem.email(
                  title: LocaleKeys.user_profile_menu_contact_support_title
                      .tr(),
                  email: _supportEmail,
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
