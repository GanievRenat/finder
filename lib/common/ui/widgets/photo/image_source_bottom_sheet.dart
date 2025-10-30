import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:injectable/injectable.dart';

@singleton
class ImageSourceBottomSheet {
  ImageSourceBottomSheet();

  Future<ImageSource?> show(BuildContext context) async {
    return await showModalBottomSheet<ImageSource?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        decoration: BoxDecoration(
          color: AppTheme.of(context).color.background,
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.only(
          left: 8,
          top: 8,
          right: 8,
          bottom: 8 + MediaQuery.of(context).padding.bottom,
        ),
        padding: EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ImageSourceButton(
              value: ImageSource.camera,
              onTap: (value) => context.pop(value),
            ),
            ImageSourceButton(
              value: ImageSource.gallery,
              onTap: (value) => context.pop(value),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageSourceButton extends StatelessWidget {
  const ImageSourceButton({
    super.key,
    required this.onTap,
    required this.value,
  });

  final Function(ImageSource value) onTap;
  final ImageSource value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(value),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (value == ImageSource.camera)
              ? Assets.images.icons.cameraButton.svg()
              : Assets.images.icons.galleryButton.svg(),
          Text(
            (value == ImageSource.camera)
                ? LocaleKeys.properties_camera.tr()
                : LocaleKeys.properties_gallery.tr(),
            style: AppTheme.of(context).textStyle.actionS,
          ),
        ],
      ),
    );
  }
}
