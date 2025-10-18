import 'package:cached_network_image/cached_network_image.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class AvatarModel extends StatelessWidget {
  const AvatarModel({super.key, required this.imageURL, this.radius = 35});

  final String imageURL;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return (imageURL.isNotEmpty) ? _buildAvatar() : emptyAvatar();
  }

  Widget emptyAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius * 2),
      child: Assets.images.icons.avatar.svg(
        width: radius * 2,
        height: radius * 2,
      ),
    );
  }

  Widget _buildAvatar() {
    return CachedNetworkImage(
      width: radius * 2,
      height: radius * 2,
      imageUrl: imageURL,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(radius * 2),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => emptyAvatar(),
    );
  }
}
