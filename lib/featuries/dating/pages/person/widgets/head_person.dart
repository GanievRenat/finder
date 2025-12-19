import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/extension/extension.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'slider_photos.dart';

class HeadPerson extends StatefulWidget {
  const HeadPerson({
    super.key,
    required this.imageUrls,
    required this.modelId,
    required this.name,
    required this.age,
    required this.onCallBack,
    required this.showControlButton,
    this.job = '',
  });

  final List<String> imageUrls;
  final String name;
  final String modelId;
  final int age;
  final String job;
  final Function(ActionCallBackPersonDetailEnums action) onCallBack;
  final bool showControlButton;

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
            child: SliderPhotos(photos: widget.imageUrls),
          ),
        ),
        Hero(
          tag: '${widget.name}, ${widget.age}, ${widget.modelId}',
          child: Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: widget.showControlButton ? 115.0 : 80.0,
              ),
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
                    widget.job.capitalize(),
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
        if (widget.showControlButton)
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: FloatingActionButton(
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
                        size: 50,
                      ),
                    ),
                  ),
                  AppSpacing.horizontal.s3,
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: FloatingActionButton(
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
                        size: 60,
                      ),
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
