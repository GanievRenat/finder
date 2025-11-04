import 'package:cached_network_image/cached_network_image.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeadPerson extends StatefulWidget {
  const HeadPerson({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.age,
    this.job = '',
  });

  final String imageUrl;
  final String name;
  final int age;
  final String job;

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
            tag: widget.imageUrl,
            child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              //width: MediaQuery.of(context).size.width,
              height: double.infinity,
              imageUrl: widget.imageUrl,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => SizedBox(),
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
                  onPressed: () {},
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
                  onPressed: () {},
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
