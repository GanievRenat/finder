import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../buttons/animation_click_widget.dart';

class AvatarProfile extends StatefulWidget {
  const AvatarProfile({
    super.key,
    this.canEdit = false,
    this.fileName = '',
    this.radius = 80,
    this.onTap,
  });

  final String fileName;
  final bool canEdit;
  final double radius;
  final VoidCallback? onTap;

  @override
  State<AvatarProfile> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  Uint8List? imageData;

  @override
  void initState() {
    // TODO: Переписать на загрузку файла из файловой системы
    if (widget.fileName.isNotEmpty) {
      rootBundle
          .load(widget.fileName)
          .then(
            (data) => setState(
              () => imageData = data.buffer.asUint8List(
                data.offsetInBytes,
                data.lengthInBytes,
              ),
            ),
          );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.canEdit) ? _buildAvatarWithEditOption() : _buildAvatar();
  }

  Widget _buildAvatarWithEditOption() {
    return AnimationClickWidget(
      onTap: widget.onTap ?? () {},
      child: Stack(
        children: [
          _buildAvatar(),
          Positioned(bottom: 0, right: 10, child: _builEditEvatarButton()),
        ],
      ),
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
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: AppTheme.of(context).color.primaryLightest,
      backgroundImage: (imageData != null)
          ? Image.memory(imageData!, fit: BoxFit.cover).image
          : null,
      child: (imageData == null && widget.fileName.isNotEmpty)
          ? CircularProgressIndicator(
              color: AppTheme.of(context).color.primaryLight,
            )
          : (imageData == null)
          ? Assets.images.icons.avatar.svg(
              fit: BoxFit.fitHeight,
              alignment: AlignmentGeometry.bottomCenter,
              height: widget.radius * 2,
            )
          : null,
    );
  }
}
