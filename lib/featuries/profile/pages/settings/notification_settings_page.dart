import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.user_profile_menu_notifications_title.tr()),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 16,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      LocaleKeys.user_profile_menu_notifications_page_subtitle
                          .tr(),
                      style: AppTheme.of(context).textStyle.bodyL,
                    ),
                  ),
                  AppSpacing.vertical.s4,
                  SwitchListTile(
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      LocaleKeys
                          .user_profile_menu_notifications_switch_text_message_title
                          .tr(),
                    ),
                    subtitle: Text(
                      LocaleKeys
                          .user_profile_menu_notifications_switch_text_message_subtitle
                          .tr(),
                    ),
                  ),
                  AppSpacing.vertical.s4,
                  SwitchListTile(
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      LocaleKeys
                          .user_profile_menu_notifications_switch_photos_title
                          .tr(),
                    ),
                    subtitle: Text(
                      LocaleKeys
                          .user_profile_menu_notifications_switch_photos_subtitle
                          .tr(),
                    ),
                  ),
                  AppSpacing.vertical.s4,
                  SwitchListTile(
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      LocaleKeys
                          .user_profile_menu_notifications_switch_videos_title
                          .tr(),
                    ),
                    subtitle: Text(
                      LocaleKeys
                          .user_profile_menu_notifications_switch_videos_subtitle
                          .tr(),
                    ),
                  ),
                  AppSpacing.vertical.s4,
                  SwitchListTile(
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      LocaleKeys
                          .user_profile_menu_notifications_switch_other_title
                          .tr(),
                    ),
                    subtitle: Text(
                      LocaleKeys
                          .user_profile_menu_notifications_switch_other_subtitle
                          .tr(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
