import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/usecase/chat/get_detail_chat_usecase.dart';
import 'package:flirta/common/service/secure_storage_service.dart';
import 'package:flirta/common/ui/widgets/buttons/close_button.dart';
import 'state/gallery_slider_cubit.dart';
import 'widgets/fragments/gallery_slider_empty_fragment.dart';
import 'widgets/fragments/gallery_slider_loader_fragment.dart';
import 'widgets/fragments/gallery_slider_data_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/gallery_slider_builder.dart';

class GallerySliderPage extends StatelessWidget {
  const GallerySliderPage({
    super.key,
    required this.modelId,
    required this.fileName,
  });

  final String modelId;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GallerySliderCubit(
        fileName: fileName,
        modelId: modelId,
        getDetailChat: getIt<GetDetailChat>(),
        secureStorageService: getIt<SecureStorageService>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            GallerySliderBuilder(
              loading: (BuildContext context) => GallerySliderLoaderFragment(),
              empty: (BuildContext context) => GallerySliderEmptyFragment(),
              success:
                  (BuildContext context, SliderData value, Widget? child) =>
                      GallerySliderDataFragment(sliderData: value),
            ),
            Positioned(
              right: 16,
              top: MediaQuery.of(context).padding.top + 16,
              child: GoToBackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
