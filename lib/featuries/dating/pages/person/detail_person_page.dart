import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/close_button.dart';
import 'widgets/head_person.dart';
import 'widgets/list_tile_bio.dart';
import 'widgets/list_tile_tags.dart';

class DetailPersonPage extends StatefulWidget {
  const DetailPersonPage({
    super.key,
    required this.person,
    required this.onPayWall,
    this.showControlButton = true,
  });

  final Person person;
  final Function() onPayWall;
  final bool showControlButton;

  @override
  State<DetailPersonPage> createState() => _DetailPersonPageState();
}

class _DetailPersonPageState extends State<DetailPersonPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: HeadPerson(
                      imageUrls: widget.person.photos,
                      name: widget.person.name,
                      age: widget.person.age,
                      job: widget.person.job,
                      onPayWall: widget.onPayWall,
                      showControlButton: widget.showControlButton,
                      onCallBack: (action) {
                        if (action == ActionCallBackPersonDetailEnums.like ||
                            action == ActionCallBackPersonDetailEnums.skip) {
                          if (getIt<DatingCubit>().canSwipe()) {
                            context.pop(action);
                          } else {
                            widget.onPayWall();
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: ListTileBio(
                      title: LocaleKeys.model_profile_bio.tr(),
                      text: widget.person.bio,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ListTileTags(
                      title: LocaleKeys.model_profile_interests.tr(),
                      tags: widget.person.interests,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      top: 16,
                      right: 16,
                      bottom: 16 + MediaQuery.of(context).padding.bottom,
                    ),
                    child: ListTileBio(
                      title: LocaleKeys.model_profile_life_style.tr(),
                      text: widget.person.lifeStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: MediaQuery.of(context).padding.top + 32,
            child: CloseModelButton(),
          ),
        ],
      ),
    );
  }
}
