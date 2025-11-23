import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'slider_photos.dart';

class HeadPerson extends StatefulWidget {
  const HeadPerson({
    super.key,
    required this.imageUrls,
    required this.name,
    required this.age,
    required this.onPayWall,
    required this.onCallBack,
    this.job = '',
  });

  final List<String> imageUrls;
  final String name;
  final int age;
  final String job;
  final Function() onPayWall;
  final Function(ActionCallBackPersonDetailEnums action) onCallBack;

  @override
  State<HeadPerson> createState() => _HeadPersonState();
}

class _HeadPersonState extends State<HeadPerson> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0, top: 0),
          child: Hero(
            tag: widget.imageUrls.first,
            child: SliderPhotos(
              photos: widget.imageUrls,
              onPayWall: widget.onPayWall,
            ),
          ),
        ),
        Align(
          alignment: AlignmentGeometry.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${widget.name}, ${widget.age}',
                  textAlign: TextAlign.center,
                  style: AppTheme.of(context).textStyle.header1.copyWith(
                    color: AppTheme.of(context).color.neutralLightLightest,
                  ),
                ),
                Text(
                  widget.job,
                  textAlign: TextAlign.center,
                  style: AppTheme.of(context).textStyle.bodyXL.copyWith(
                    color: AppTheme.of(context).color.neutralLightLightest,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: AlignmentGeometry.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'skipButton',
                  backgroundColor: AppTheme.of(
                    context,
                  ).color.neutralLightLightest,
                  mini: false,
                  onPressed: () {
                    widget.onCallBack(ActionCallBackPersonDetailEnums.skip);
                  },
                  shape: CircleBorder(),
                  child: Icon(
                    CupertinoIcons.clear,
                    color: AppTheme.of(context).color.red,
                    size: 30,
                  ),
                ),
                AppSpacing.horizontal.s3,
                FloatingActionButton(
                  heroTag: 'likeButton',
                  backgroundColor: Colors.white,
                  mini: false,
                  onPressed: () {
                    widget.onCallBack(ActionCallBackPersonDetailEnums.like);
                  },
                  shape: CircleBorder(),
                  child: Icon(
                    CupertinoIcons.heart_solid,
                    color: AppTheme.of(context).color.primaryDarkset,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
