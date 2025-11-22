import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/head_person.dart';

class DetailPersonPage extends StatefulWidget {
  const DetailPersonPage({
    super.key,
    required this.person,
    required this.onPayWall,
  });

  final Person person;
  final Function onPayWall;

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
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: HeadPerson(
                    imageUrl: (widget.person.photos.isNotEmpty)
                        ? widget.person.photos.first
                        : '',
                    name: widget.person.name,
                    age: widget.person.age,
                    job: widget.person.job,
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
                      ).color.neutralLightLightest.withAlpha(180),
                      radius: 16,
                      child: Icon(
                        Icons.close_rounded,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.of(context).color.neutralDarkDarkset,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.model_profile_bio.tr(),
                    style: AppTheme.of(context).textStyle.header4,
                  ),
                  Text(
                    widget.person.bio,
                    softWrap: true,
                    style: AppTheme.of(context).textStyle.bodyM,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.model_profile_interests.tr(),
                    style: AppTheme.of(context).textStyle.header4,
                  ),
                  AppSpacing.vertical.s4,
                  GroupPersonTags(tags: widget.person.interests.toSet()),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.model_profile_life_style.tr(),
                    style: AppTheme.of(context).textStyle.header4,
                  ),
                  Text(
                    widget.person.lifeStyle,
                    softWrap: true,
                    style: AppTheme.of(context).textStyle.bodyM,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
