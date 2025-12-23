import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/person/person.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import 'widgets/heart_widget.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key, required this.person});

  final Person person;

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  late VideoPlayerController _controller;
  bool _isInitializedController = false;

  @override
  void initState() {
    super.initState();

    if (widget.person.video.isNotEmpty) {
      _controller =
          VideoPlayerController.networkUrl(
              Uri.parse(widget.person.video),
              videoPlayerOptions: VideoPlayerOptions(
                allowBackgroundPlayback: false,
              ),
            )
            ..initialize().then((_) {
              setState(() {});
              _controller.setVolume(0.0);
              _controller.setLooping(true);
              _controller.play();
            });
      _isInitializedController = true;
    }
  }

  @override
  void dispose() {
    if (_isInitializedController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: (widget.person.video.isNotEmpty)
                ? (_controller.value.isInitialized)
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 1.77777,
                            child: VideoPlayer(_controller),
                          ),
                        )
                      : CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          //width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          imageUrl: widget.person.photos.isNotEmpty
                              ? widget.person.photos.first
                              : '',
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => SizedBox(),
                        )
                : CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    //width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    imageUrl: widget.person.photos.isNotEmpty
                        ? widget.person.photos.first
                        : '',
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => SizedBox(),
                  ),
          ),
          Positioned(
            right: 16,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: CircleAvatar(
                backgroundColor: AppTheme.of(
                  context,
                ).color.neutralLightLightest,
                radius: 16,
                child: Icon(
                  Icons.close_rounded,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.of(context).color.neutralDarkDarkset,
                ),
              ),
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
                    colors: [Colors.black.withAlpha(100), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16 + MediaQuery.of(context).padding.bottom,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeartWidget(),
                  AppSpacing.vertical.s5,
                  Text(
                    LocaleKeys.dating_match_message.tr(
                      args: [widget.person.name],
                    ),
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context).textStyle.header2.copyWith(
                      color: AppTheme.of(context).color.neutralLightLightest,
                      height: 1.2,
                    ),
                  ),
                  AppSpacing.vertical.s8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: MainButton.inversion(
                      title: LocaleKeys.dating_match_button_title.tr(),
                      onPressed: () {
                        context.pop(true);
                      },
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
