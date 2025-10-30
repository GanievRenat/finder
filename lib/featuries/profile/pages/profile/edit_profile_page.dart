import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/profile.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../widgets/profile_head.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key, required this.onDeleteProfile});
  final Function onDeleteProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.user_profile_menu_your_profile_title_page.tr()),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          top: 16,
          right: 16,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileHead(canEdit: true, onTap: () {}),
                    ListTileProfileItem(
                      title: LocaleKeys
                          .user_profile_menu_your_profile_field_name
                          .tr(),
                      subtitle: 'Sara',
                      onTap: () {},
                    ),
                    AppSpacing.vertical.s3,
                    ListTileProfileItem(
                      title: LocaleKeys
                          .user_profile_menu_your_profile_field_gender
                          .tr(),
                      subtitle: 'Male',
                      onTap: () {},
                    ),
                    AppSpacing.vertical.s3,
                    ListTileProfileItem(
                      title: LocaleKeys.user_profile_menu_your_profile_field_age
                          .tr(),
                      subtitle: '24',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            AppSpacing.vertical.s3,
            DeleteProfileButton(
              onSuccess: () {
                onDeleteProfile();
              },
            ),
          ],
        ),
      ),
    );
  }
}
