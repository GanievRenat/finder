import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/usecase/chat/get_detail_chat_usecase.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'widgets/fragments/gallery_empty_fragment.dart';
import 'widgets/fragments/gallery_loader_fragment.dart';
import 'widgets/fragments/gallery_data_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state/gallery_cubit.dart';
import 'widgets/gallery_chat_builder.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({
    super.key,
    required this.person,
    required this.onSliderPhoto,
    required this.onPayWall,
  });

  final Function({required String fileName, required String modelId})
  onSliderPhoto;
  final Function() onPayWall;
  final Person person;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryCubit(
        modelId: person.modelId,
        getDetailChat: getIt<GetDetailChat>(),
        appStateService: getIt<AppStateService>(),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.chat_menu_1.tr())),
        body: GalleryChatBuilder(
          init: (BuildContext context) => GalleryLoaderFragment(),
          loading: (BuildContext context) => GalleryLoaderFragment(),
          empty: (BuildContext context) => GalleryEmptyFragment(),
          error: (BuildContext context, value, Widget? child) =>
              GalleryEmptyFragment(),
          success:
              (BuildContext context, List<PhotoGroup> value, Widget? child) =>
                  GalleryDataFragment(
                    onSliderPhoto: (fileName) {
                      onSliderPhoto(
                        fileName: fileName,
                        modelId: person.modelId,
                      );
                    },
                    onPayWall: onPayWall,
                    isPremium: true,
                    dataSource: value,
                    modelId: person.modelId,
                  ),
          noPremium:
              (BuildContext context, List<PhotoGroup> value, Widget? child) =>
                  GalleryDataFragment(
                    onSliderPhoto: (fileName) {
                      onSliderPhoto(
                        fileName: fileName,
                        modelId: person.modelId,
                      );
                    },
                    onPayWall: onPayWall,
                    isPremium: false,
                    dataSource: value,
                    modelId: person.modelId,
                  ),
        ),
      ),
    );
  }
}
