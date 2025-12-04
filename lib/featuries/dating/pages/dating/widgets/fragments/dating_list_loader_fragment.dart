import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DatingListLoaderFragment extends StatelessWidget {
  const DatingListLoaderFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppTheme.of(context).color.neutralLightMedium,
        highlightColor: AppTheme.of(context).color.neutralLightLightest,
        duration: Duration(seconds: 2),
      ),
      enabled: true,
      ignoreContainers: false,
      child: SizedBox(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0, top: 16),
              child: SizedBox(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: AppTheme.of(context).color.neutralLightLight,
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 115.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'NameName, 18',
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).textStyle.header1.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    Text(
                      'StudentStudent',
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
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: FloatingActionButton(
                        heroTag: 'undoButton',
                        backgroundColor: AppTheme.of(
                          context,
                        ).color.neutralLightLightest,
                        mini: true,
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          CupertinoIcons.clear,
                          color: AppTheme.of(context).color.red,
                          size: 30,
                        ),
                      ),
                    ),
                    AppSpacing.horizontal.s3,
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: FloatingActionButton(
                        heroTag: 'likeButton',
                        backgroundColor: AppTheme.of(
                          context,
                        ).color.neutralLightLightest,
                        mini: false,
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          CupertinoIcons.heart_solid,
                          color: AppTheme.of(context).color.primaryDarkset,
                          size: 30,
                        ),
                      ),
                    ),
                    AppSpacing.horizontal.s3,
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: FloatingActionButton(
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
