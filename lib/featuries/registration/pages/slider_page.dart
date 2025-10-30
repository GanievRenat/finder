import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/buttons/main_button.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderPage extends StatelessWidget {
  SliderPage({super.key, required this.onEnterName});

  final Function onEnterName;

  final PageController pageController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Assets.images.gender.image(fit: BoxFit.cover)),
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
                    SizedBox(
                      height: 60,
                      child: PageView(
                        controller: pageController,
                        children: [
                          Text(
                            LocaleKeys.auth_slider_0.tr(),
                            softWrap: true,
                            style: AppTheme.of(context).textStyle.header3
                                .copyWith(
                                  color: AppTheme.of(
                                    context,
                                  ).color.neutralLightLightest,
                                  height: 1,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            LocaleKeys.auth_slider_1.tr(),
                            softWrap: true,
                            style: AppTheme.of(context).textStyle.header3
                                .copyWith(
                                  color: AppTheme.of(
                                    context,
                                  ).color.neutralLightLightest,
                                  height: 1,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            LocaleKeys.auth_slider_2.tr(),
                            softWrap: true,
                            style: AppTheme.of(context).textStyle.header3
                                .copyWith(
                                  color: AppTheme.of(
                                    context,
                                  ).color.neutralLightLightest,
                                  height: 1,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
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
                      onPressed: () => onEnterName(),
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
