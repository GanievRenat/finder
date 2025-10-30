import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/featuries/profile/profile.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key, required this.onDeleteProfile});
  final Function onDeleteProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.user_profile_menu_your_profile_title_page.tr()),
      ),
      body: BackgroundProfile(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ProfileHead(canEdit: true), ProfileInfo()],
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
