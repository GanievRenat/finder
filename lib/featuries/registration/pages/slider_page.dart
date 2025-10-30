import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/buttons/main_button.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key, required this.onEnterName});

  final Function onEnterName;

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  late VideoPlayerController _controller;

  final PageController pageController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/videos/slider_1.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _controller.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 1.77777,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Assets.images.firstSlider.image(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 1.77777,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withAlpha(180), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: PageView(
              controller: pageController,
              children: [
                ScrollTextPage(text: LocaleKeys.auth_slider_0.tr()),
                ScrollTextPage(text: LocaleKeys.auth_slider_1.tr()),
                ScrollTextPage(text: LocaleKeys.auth_slider_2.tr()),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom == 0
                ? 32
                : MediaQuery.of(context).padding.bottom,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      axisDirection: Axis.horizontal,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppTheme.of(
                          context,
                        ).color.primaryDarkset,
                        dotColor: AppTheme.of(
                          context,
                        ).color.neutralLightLightest.withAlpha(100),
                        dotWidth: 8,
                        dotHeight: 8,
                      ),
                    ),
                    SizedBox(height: 8),
                    MainButton.inversion(
                      title: LocaleKeys.auth_button_get_start.tr(),
                      onPressed: () async {
                        await _controller.pause();
                        widget.onEnterName();
                      },
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

class ScrollTextPage extends StatelessWidget {
  const ScrollTextPage({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top:
            MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.bottom + 45 + 32 + 50),
        left: 16,
        right: 16,
      ),
      child: Text(
        text,
        softWrap: true,
        style: AppTheme.of(context).textStyle.header3.copyWith(
          color: AppTheme.of(context).color.neutralLightLightest,
          height: 1,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.background,
    required this.title,
  });

  final Widget background;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned.fill(child: background),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withAlpha(180), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom == 0
                ? 32 + 45 + 8 + 8 + 32
                : MediaQuery.of(context).padding.bottom + 45 + 8 + 8 + 32,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  title,
                  softWrap: true,
                  style: AppTheme.of(context).textStyle.header3.copyWith(
                    color: AppTheme.of(context).color.neutralLightLightest,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
