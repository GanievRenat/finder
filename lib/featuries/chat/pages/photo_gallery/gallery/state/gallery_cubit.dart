import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/service/app_state_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_state.dart';
part 'gallery_cubit.freezed.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit({
    required this.modelId,
    required GetDetailChat getDetailChat,
    required AppStateService appStateService,
  }) : _getDetailChat = getDetailChat,
       _appStateService = appStateService,
       super(GalleryState.init()) {
    getGalleryData();
  }

  final GetDetailChat _getDetailChat;
  final AppStateService _appStateService;
  final String modelId;

  void getGalleryData() async {
    emit(GalleryState.loading());
    // Получаем все сообщения чата
    var listMessage = await _getDetailChat(modelId);
    if (listMessage.isRight) {
      List<PhotoGroup> photoGroup = [];

      Map<String, List<String>> mapPhotoGroup = {};
      for (var msg in listMessage.right) {
        if (msg.imageUrls.isNotEmpty) {
          String dateGroup =
              '${msg.atCreated.day}.${msg.atCreated.month}.${msg.atCreated.year}';

          var listGroup = mapPhotoGroup[dateGroup] ?? [];

          listGroup.addAll(msg.imageUrls);

          mapPhotoGroup[dateGroup] = listGroup;
        }
      }

      if (mapPhotoGroup.isNotEmpty) {
        photoGroup = mapPhotoGroup.keys
            .map(
              (group) => PhotoGroup(
                sectionName: group,
                listItems: mapPhotoGroup[group] ?? [],
              ),
            )
            .toList()
            .reversed
            .toList();

        // Получаем состояние premium
        bool premium = _appStateService.isPremium;
        if (premium) {
          emit(GalleryState.data(photoGroup));
        } else {
          emit(GalleryState.dataIsNotPremium(photoGroup));
        }
        return;
      }
    }

    emit(GalleryState.empty());
  }
}

class PhotoGroup {
  PhotoGroup({required this.sectionName, required this.listItems});

  final String sectionName;
  final List<String> listItems;
}
