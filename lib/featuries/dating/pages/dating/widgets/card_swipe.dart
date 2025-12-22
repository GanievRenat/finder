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
  PageController controller = PageController();

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
              child: (widget.person.photos.length > 1)
                  ? GestureDetector(
                      onTapUp: (TapUpDetails details) {
                        // Получаем координаты касания относительно виджета
                        final localPosition = details.localPosition;
                        if (localPosition.dx < 100) {
                          if ((controller.page?.toInt() ?? 0) > 0) {
                            controller.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                          }
                        } else if (localPosition.dx >
                            MediaQuery.of(context).size.width - 100) {
                          if ((controller.page?.toInt() ?? 0) <
                              widget.person.photos.length - 1) {
                            controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                          }
                        }
                      },
                      child: PageView.builder(
                        controller: controller,
                        itemBuilder: (context, index) => ImageProfileOfPerson(
                          key: ValueKey(widget.person.photos[index]),
                          url: widget.person.photos[index],
                        ),
                        itemCount: widget.person.photos.length,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    )
                  : ImageProfileOfPerson(
                      key: ValueKey(
                        widget.person.photos.isNotEmpty
                            ? widget.person.photos.first
                            : '',
                      ),
                      url: widget.person.photos.isNotEmpty
                          ? widget.person.photos.first
                          : '',
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

class ImageProfileOfPerson extends StatelessWidget {
  const ImageProfileOfPerson({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.of(context).color.neutralLightLight,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        height: double.infinity,
        imageUrl: url,
        placeholder: (context, url) => Skeletonizer(
          enabled: true,
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
    );
  }
}
