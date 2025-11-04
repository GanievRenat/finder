import 'package:cached_network_image/cached_network_image.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class CardSwipe extends StatefulWidget {
  const CardSwipe({
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
  State<CardSwipe> createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.imageUrl,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0, top: 16),
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
        ],
      ),
    );
  }
}
