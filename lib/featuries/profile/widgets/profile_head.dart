import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/widgets/profile_builder.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../common/ui/theme/app_theme.dart';

class ProfileHead extends StatelessWidget {
  const ProfileHead({super.key, this.canEdit = false});

  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return ProfileBuilder(
      init: (BuildContext context) => ProfileHeadLoading(),
      loading: (BuildContext context) => ProfileHeadLoading(),
      error: (BuildContext context, value, Widget? child) => ProfileHeadError(),
      success: (BuildContext context, value, Widget? child) =>
          ProfileHeadData(user: value, canEdit: canEdit, onTap: () {}),
    );
  }
}

class ProfileHeadData extends StatelessWidget {
  const ProfileHeadData({
    super.key,
    required this.user,
    this.canEdit = false,
    this.onTap,
  });

  final User user;
  final bool canEdit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AvatarProfile(
          fileName: Assets.images.gender.path,
          canEdit: canEdit,
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 32),
          child: Text(
            '${user.name}, ${user.age}',
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.header1,
          ),
        ),
      ],
    );
  }
}

class ProfileHeadError extends StatelessWidget {
  const ProfileHeadError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AvatarProfile(fileName: ''),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 32),
          child: Text(
            '-, -',
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.header1,
          ),
        ),
      ],
    );
  }
}

class ProfileHeadLoading extends StatelessWidget {
  const ProfileHeadLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      ignoreContainers: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AvatarProfile(fileName: ''),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 32),
            child: Text(
              '-, -',
              textAlign: TextAlign.center,
              style: AppTheme.of(context).textStyle.header1,
            ),
          ),
        ],
      ),
    );
  }
}
