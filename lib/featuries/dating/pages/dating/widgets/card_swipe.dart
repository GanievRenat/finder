import 'package:cached_network_image/cached_network_image.dart';
import 'package:flirta/common/domain/entites/person/person.dart';
import 'package:flirta/common/extension/extension.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardSwipe extends StatefulWidget {
  const CardSwipe({super.key, required this.person, required this.onTap});

  final Person person;
  final Function() onTap;

  @override
  State<CardSwipe> createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Stack(
        children: [
          Hero(
            tag: widget.person.photos.isNotEmpty
                ? widget.person.photos.first
                : '',
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0, top: 16),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                height: double.infinity,
                imageUrl: widget.person.photos.isNotEmpty
                    ? widget.person.photos.first
                    : '',
                placeholder: (context, url) => Skeletonizer(
                  enabled: true,
                  ignoreContainers: false,
                  child: SizedBox(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: AppTheme.of(context).color.neutralLightLight,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppTheme.of(context).color.primaryLightest,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80 * 2),
                      child: Assets.images.icons.avatar.svg(
                        width: 80 * 2,
                        height: 80 * 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Hero(
            tag:
                '${widget.person.name}, ${widget.person.age}, ${widget.person.modelId}',
            child: Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 115.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.person.name}, ${widget.person.age}',
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).textStyle.header1.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    Text(
                      widget.person.job.capitalize(),
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).textStyle.bodyXL.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
