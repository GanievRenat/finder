import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/head_person.dart';

class DetailPersonPage extends StatefulWidget {
  const DetailPersonPage({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.job,
    required this.age,
  });

  final String imageUrl;
  final String name;
  final int age;
  final String job;

  @override
  State<DetailPersonPage> createState() => _DetailPersonPageState();
}

class _DetailPersonPageState extends State<DetailPersonPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      log('${scrollController.offset}');
      if (scrollController.offset < -50) {
        if (context.canPop()) {
          context.pop();
        }
      }
    });
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: HeadPerson(
                imageUrl: widget.imageUrl,
                name: widget.name,
                age: widget.age,
                job: widget.job,
              ),
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
                    'My name is Jessica Parker and I enjoy meeting new people and finding ways to help them have an uplifting experience.',
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
                  GroupPersonTags(
                    tags: {
                      'Fitness',
                      'Cooking',
                      'Gamer',
                      'Travelling',
                      'Photo',
                      'Music',
                    },
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
                    LocaleKeys.model_profile_life_style.tr(),
                    style: AppTheme.of(context).textStyle.header4,
                  ),
                  Text(
                    'Description. Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do',
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
