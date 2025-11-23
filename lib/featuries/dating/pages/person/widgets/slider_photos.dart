import 'package:cached_network_image/cached_network_image.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderPhotos extends StatefulWidget {
  const SliderPhotos({
    super.key,
    required this.photos,
    required this.onPayWall,
  });

  final List<String> photos;
  final Function() onPayWall;

  @override
  State<SliderPhotos> createState() => _SliderPhotosState();
}

class _SliderPhotosState extends State<SliderPhotos> {
  final PageController _pageController = PageController(keepPage: true);
  Map<int, ImageProvider> imageProviders = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.photos.length > 1) {
      _precacheImages(1);
      if (widget.photos.length > 2) {
        _precacheImages(2);
      }
      if (widget.photos.length > 3) {
        _precacheImages(3);
      }
    }
    super.didChangeDependencies();
  }

  Future<bool> _precacheImages(int index) async {
    final imageProvider = CachedNetworkImageProvider(widget.photos[index]);
    await precacheImage(imageProvider, context);
    imageProviders[index] = imageProvider;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.photos.length,
            onPageChanged: (value) {
              if (value + 1 <= widget.photos.length &&
                  imageProviders[value + 1] == null) {
                _precacheImages(value + 1);
              }
              if (value + 2 <= widget.photos.length &&
                  imageProviders[value + 2] == null) {
                _precacheImages(value + 2);
              }
              if (value + 3 <= widget.photos.length &&
                  imageProviders[value + 3] == null) {
                _precacheImages(value + 3);
              }

              if (value > 0) {
                if (!getIt<AppStateService>().isPremium) {
                  _pageController.jumpToPage(0);
                  widget.onPayWall();
                }
              }
            },
            itemBuilder: (context, index) {
              return ImagePage(
                imageUrl: widget.photos[index],
                imageProvider: imageProviders[index],
              );
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 4,
          left: 16,
          child: SmoothPageIndicator(
            controller: _pageController,
            axisDirection: Axis.horizontal,
            count: widget.photos.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppTheme.of(context).color.neutralLightLightest,
              dotColor: AppTheme.of(
                context,
              ).color.neutralDarkDarkset.withAlpha(50),
              paintStyle: PaintingStyle.fill,
              dotWidth:
                  ((MediaQuery.of(context).size.width - 32) -
                      ((widget.photos.length - 1) * 3)) /
                  widget.photos.length,
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

class ImagePage extends StatelessWidget {
  final String imageUrl;
  final ImageProvider? imageProvider;

  const ImagePage({super.key, required this.imageUrl, this.imageProvider});

  @override
  Widget build(BuildContext context) {
    if (imageProvider != null) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider!, fit: BoxFit.fitHeight),
        ),
        child: SizedBox(),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.fitHeight),
          ),
        ),
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.fitHeight,
      );
    }
  }
}
