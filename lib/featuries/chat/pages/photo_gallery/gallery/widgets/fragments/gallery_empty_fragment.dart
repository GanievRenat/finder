import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/buttons/main_button.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GalleryEmptyFragment extends StatelessWidget {
  const GalleryEmptyFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(),
          Assets.images.icons.emptyGallery.svg(),
          AppSpacing.vertical.s8,
          Text(
            LocaleKeys.chat_gallery_empty_title.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.header2.copyWith(
              color: AppTheme.of(context).color.neutralDarkDarkset,
            ),
          ),
          AppSpacing.vertical.s1,
          Text(
            LocaleKeys.chat_gallery_empty_subtitle.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.bodyL.copyWith(
              color: AppTheme.of(context).color.neutralDarkLight,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: MainButton(
              title: LocaleKeys.chat_gallery_empty_button.tr(),
              onPressed: () => context.pop(),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
