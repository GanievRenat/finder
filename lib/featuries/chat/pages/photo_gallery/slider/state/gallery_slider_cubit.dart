import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/service/secure_storage_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_slider_state.dart';
part 'gallery_slider_cubit.freezed.dart';

class GallerySliderCubit extends Cubit<GallerySliderState> {
  GallerySliderCubit({
    required this.modelId,
    required this.fileName,
    required GetDetailChat getDetailChat,
    required SecureStorageService secureStorageService,
  }) : _getDetailChat = getDetailChat,
       _secureStorageService = secureStorageService,
       super(GallerySliderState.loading()) {
    getGallerySliderData();
  }

  final GetDetailChat _getDetailChat;
  final SecureStorageService _secureStorageService;
  final String modelId;
  final String fileName;

  void getGallerySliderData() async {
    emit(GallerySliderState.loading());

    var listMessage = await _getDetailChat(modelId);
    var path = await _secureStorageService.getFullPath(modelId);

    if (listMessage.isRight) {
      List<String> photoList = [];

      for (var msg in listMessage.right) {
        if (msg.imageUrls.isNotEmpty) {
          photoList.addAll(msg.imageUrls.map((e) => '$path/$e').toList());
        }
      }

      var initPage = photoList.indexWhere(
        (element) => element == '$path/$fileName',
      );
      if (initPage == -1) initPage = 0;

      emit(
        GallerySliderState.data(
          SliderData(dataSource: photoList, initPage: initPage),
        ),
      );
      return;
    }
    emit(GallerySliderState.empty());
  }
}

class SliderData {
  final List<String> dataSource;
  final int initPage;
  SliderData({required this.dataSource, required this.initPage});
}
