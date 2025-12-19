import 'dart:io';
import 'dart:ui';

import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../state/gallery_slider_cubit.dart';

class GallerySliderDataFragment extends StatefulWidget {
  const GallerySliderDataFragment({super.key, required this.sliderData});

  final SliderData sliderData;

  @override
  State<GallerySliderDataFragment> createState() =>
      _GallerySliderDataFragmentState();
}

class _GallerySliderDataFragmentState extends State<GallerySliderDataFragment> {
  late PageController controller;

  TransformationController transformationController =
      TransformationController();

  double _correctScaleValue = 1.0;

  GlobalKey sliderFront = GlobalKey();

  File? fileBackround;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.sliderData.initPage);
    if (widget.sliderData.dataSource.isNotEmpty) {
      fileBackround = File(
        widget.sliderData.dataSource[widget.sliderData.initPage],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: Duration(seconds: 2),
            transitionBuilder: (Widget child, Animation<double> animation) {
              // Стандартная анимация fade
              return FadeTransition(opacity: animation, child: child);
            },
            child: SizedBox(
              key: ValueKey(fileBackround?.path ?? 'def'),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: (fileBackround != null)
                  ? ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                      child: Image.file(
                        key: ValueKey(1),
                        fileBackround!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(color: Colors.red),
            ),
          ),
        ),
        Positioned.fill(
          key: sliderFront,
          child: PageView.builder(
            physics: (_correctScaleValue > 1.0)
                ? const NeverScrollableScrollPhysics()
                : null,
            controller: controller,
            itemCount: widget.sliderData.dataSource.length,
            onPageChanged: (value) {
              setState(() {
                fileBackround = File(widget.sliderData.dataSource[value]);
              });
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                maxScale: 3,
                transformationController: transformationController,
                onInteractionEnd: (value) {
                  setState(() {
                    _correctScaleValue = transformationController.value
                        .getMaxScaleOnAxis();
                  });
                },
                child: Image.file(File(widget.sliderData.dataSource[index])),
              );
            },
          ),
        ),
        if (widget.sliderData.dataSource.length > 1)
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            child: SmoothPageIndicator(
              controller: controller,
              axisDirection: Axis.horizontal,
              count: widget.sliderData.dataSource.length,
              effect: ExpandingDotsEffect(
                activeDotColor: AppTheme.of(context).color.neutralLightLightest,
                dotColor: AppTheme.of(
                  context,
                ).color.neutralDarkDarkset.withAlpha(50),
                paintStyle: PaintingStyle.fill,
                dotWidth:
                    ((MediaQuery.of(context).size.width - 32) -
                        ((widget.sliderData.dataSource.length - 1) * 3)) /
                    widget.sliderData.dataSource.length,
                dotHeight: 4,
                radius: 2,
                spacing: 3,
                expansionFactor: 1.000001,
              ),
            ),
          ),
      ],
    );
  }
}
