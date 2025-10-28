import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/app_theme.dart';

class ProfileHead extends StatelessWidget {
  const ProfileHead({super.key, this.canEdit = false, this.onTap});

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
            'Renat, 33',
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.header1,
          ),
        ),
      ],
    );
  }
}
