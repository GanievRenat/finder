import 'dart:io';

import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/photo_picker_service.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/pages/profile/state/profile_cubit.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../buttons/animation_click_widget.dart';

class AvatarProfile extends StatefulWidget {
  const AvatarProfile({
    super.key,
    this.pathToImage = '',
    this.canEdit = false,
    this.radius = 80,
  });

  final bool canEdit;
  final double radius;
  final String pathToImage;

  @override
  State<AvatarProfile> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.canEdit) ? _buildAvatarWithEditOption() : _buildAvatar();
  }

  Widget _buildAvatarWithEditOption() {
    return widget.canEdit
        ? AnimationClickWidget(
            onTap: () async {
              var imageSource = await ImageSourceBottomSheet().show(context);
              if (imageSource == ImageSource.camera) {
                final image = await getIt<PhotoPickerService>()
                    .takePhotoWithCamera();
                if (image != null) {
                  getIt<ProfileCubit>().updatePhoto(image.path);
                }
              } else if (imageSource == ImageSource.gallery) {
                final image = await getIt<PhotoPickerService>()
                    .pickImageFromGallery();
                if (image != null) {
                  getIt<ProfileCubit>().updatePhoto(image.path);
                }
              }
            },
            child: Stack(
              children: [
                _buildAvatar(),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: _builEditEvatarButton(),
                ),
              ],
            ),
          )
        : Stack(
            children: [
              _buildAvatar(),
              Positioned(bottom: 0, right: 10, child: _builEditEvatarButton()),
            ],
          );
  }

  Widget _builEditEvatarButton() {
    return CircleAvatar(
      radius: 16,
      backgroundColor: AppTheme.of(context).color.primaryDarkset,
      child: Icon(
        Icons.edit,
        color: AppTheme.of(context).color.neutralLightLightest,
        size: 22,
      ),
    );
  }

  Widget _buildAvatar() {
    File filePhoto = File(widget.pathToImage);
    if (widget.pathToImage.isNotEmpty) {
      if (filePhoto.existsSync()) {
        return CircleAvatar(
          radius: widget.radius,
          backgroundColor: AppTheme.of(context).color.primaryLightest,
          backgroundImage: Image.file(filePhoto, fit: BoxFit.cover).image,
        );
      }
    }
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: AppTheme.of(context).color.primaryLightest,
      child: Assets.images.icons.avatar.svg(
        fit: BoxFit.fitHeight,
        alignment: AlignmentGeometry.bottomCenter,
        height: widget.radius * 2,
      ),
    );
  }
}
